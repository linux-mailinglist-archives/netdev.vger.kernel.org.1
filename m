Return-Path: <netdev+bounces-221472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5FB50943
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631A0541112
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239DA287515;
	Tue,  9 Sep 2025 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq+4oSgF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E128726B
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460784; cv=none; b=MnVw5sL7uWcZ/79vnDwLGBEhr3UgZ5/DG+sbd5VZFQp1wHeQXOG4m7IzYbiFKNoouxkZQtOmHLAAuvghzEeieZQDgHJyhRz3OSFZfPLGoOUN95GK9DwIGsiZDk0UKzwKC90RD5ufqf/HeCQaHrrLPIJdV5TQhyndkFTvSc2HppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460784; c=relaxed/simple;
	bh=4UKFJl1cPbs1SFTPgxONkfgxzCJLRGsIr01LnYJcHmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlZK6Ms63Ckbw2+9VVD6KYzghAkaWJ+qAoI8Z19VS1lCmD3XeRV5JLcbARLXbD2MP/1ACSzkAHon65EEKuLFfE1Lv9M6m+TCrJJ712Sb7Vr2OqFr5A3ZpIA5dxAfDoJXzFHB5ruMC3oo/LvLFqA9YBpploXhCCkt/S3Dqsqd12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq+4oSgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE46C4CEF4;
	Tue,  9 Sep 2025 23:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460783;
	bh=4UKFJl1cPbs1SFTPgxONkfgxzCJLRGsIr01LnYJcHmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uq+4oSgF0OYlKge8r0q5ITxYXyMxPMmQyU6lffeSVZ+Sccwbri8tLsC9681LjMAMZ
	 hKPGvhZc/YzLnRbKyBHts8+wZa2USrzHCf/h9iG8j81/w7t+BnAdCUluF4EDhjLSA6
	 D4Fooc3n5V3tE4RbjkXCjuicx9xqUPf8V4J2ND3deSAUVvjXGj/2c8ar1v4yeL945P
	 5kFjXNBBi7T3VEsscpU5YUTfTp0J9s8U3pVUgLh58CD+wLoZ59GSCcbZ4PpS8AD9x/
	 NQpAu5+TY3jAfaO2pL0rB2Q/Of8dRyKRNpGQ87Bw3sS6ch/HaYZ5SJ56FaZ7A4PGDZ
	 TnW2ITr31SyUw==
Date: Tue, 9 Sep 2025 16:33:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Alexandra Winter
 <wintera@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Shannon Nelson <sln@onemain.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
Message-ID: <20250909163302.7e03d232@kernel.org>
In-Reply-To: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
References: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 07 Sep 2025 21:43:20 +0100 Russell King (Oracle) wrote:
> In C, enumerated types do not have a defined size, apart from being
> compatible with one of the standard types. This allows an ABI /
> compiler to choose the type of an enum depending on the values it
> needs to store, and storing larger values in it can lead to undefined
> behaviour.
> 
> The tx_type and rx_filters members of struct kernel_ethtool_ts_info
> are defined as enumerated types, but are bit arrays, where each bit
> is defined by the enumerated type. This means they typically store
> values in excess of the maximum value of the enumerated type, in
> fact (1 << max_value) and thus must not be declared using the
> enumated type.
> 
> Fix both of these to use u32, as per the corresponding __u32 UAPI type.
> 
> Fixes: 2111375b85ad ("net: Add struct kernel_ethtool_ts_info")

Do you feel strongly about this being a fix? (I can adjust when
applying FWIW). It's clearly not great but I don't think storing
a mask of enum values cause functional problems.

