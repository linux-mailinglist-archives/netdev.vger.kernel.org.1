Return-Path: <netdev+bounces-248311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6DD06CC7
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1222303E0C3
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D31266B67;
	Fri,  9 Jan 2026 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEvy1Q0A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A1263F52
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924664; cv=none; b=XSA7HpuAIHmNRaRwLpPzavUdr3w1xBJ7lbrB/2TDm9s0VpUZ+saguz+OIufK35TYb6AmB7U3QVp/kyPN/A2CTlSIsWokBXmVoGHT7EbTFjwAvIfmmedAgrl8HWWtLFwxe3ibsttMKGQs4CdmbK0ZJzCsoMiX4kefSuwBoagxEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924664; c=relaxed/simple;
	bh=ZSH1x6/PudRoA0hAnHnHX/1eGRRQy1dimwpiZlqOARE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvetPi43uafCqMRJs7/SQIOw7W2aoF43/pp2D1kmsUwTrJsb3kGYUXvqlOtNEafgUeZz47IzJ5jxBLwnUhpiZTg9dP+pR8kHqg23xBiawTqmy2rVa5EEah/gDmSn5MyCDP36Qs2u5MwhEWV7FZIjsOM2pbJR7QBVmORYAl+6au8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEvy1Q0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA8AC116C6;
	Fri,  9 Jan 2026 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924663;
	bh=ZSH1x6/PudRoA0hAnHnHX/1eGRRQy1dimwpiZlqOARE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jEvy1Q0AVv1pC+WZrn/GGGa5sH9iyfBVzHKWj8KhF0OZLdxiM2wFSjKHY8RGPao9q
	 R7GPLauJ53Cif6MqojCwqYctr7Vg4G5yACvyKLnw3RznjFm9Ti3sRY8vu5hObxzaIS
	 tOM3KKmdx7LOJHvdLo5HZhLRahXSrmLlaDwQKrmF0DQpmPBgWgwqAf2ePsMiuVvaY2
	 TFZkq0UGFMQZK1fE6pHSqsZyrgMQVoo82pOblmzcHKrOAX7Fun5sqsMLEsRrRY3PpA
	 TSl5Ly5PapWcq/ohsAb9TTTfgejsYnogOrB+klbtOfQnBjnjWAEwtCOKxZJpvHPuTC
	 cnFxsZQQykv6g==
Date: Thu, 8 Jan 2026 18:11:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed
 PHYs with static array
Message-ID: <20260108181102.4553d618@kernel.org>
In-Reply-To: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 17:56:26 +0100 Heiner Kallweit wrote:
> +/* The DSA loop driver may allocate 4 fixed PHY's, and 4 additional
> + * fixed PHY's for a system should be sufficient.
> + */
> +#define NUM_FP	8
> +
>  struct fixed_phy {
> -	int addr;
>  	struct phy_device *phydev;
>  	struct fixed_phy_status status;
>  	int (*link_update)(struct net_device *, struct fixed_phy_status *);
> -	struct list_head node;
>  };
>  
> +static struct fixed_phy fmb_fixed_phys[NUM_FP];
>  static struct mii_bus *fmb_mii_bus;
> -static LIST_HEAD(fmb_phys);
> +static DEFINE_IDA(phy_fixed_ida);

Isn't IDA an overkill for a range this tiny?
IDA is useful if the ID range is large and may be sparse.
Here a bitmap would suffice.

DECLARE_BITMAP(phy_fixed_ids, NUM_FP); 

id = find_first_zero_bit(phy_fixed_ids, NUM_FP);
if (id >= NUM_FP)
	return -ENOSPC;

set_bit(id, phy_fixed_ids);
...

