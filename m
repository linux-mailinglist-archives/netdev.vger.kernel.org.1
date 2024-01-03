Return-Path: <netdev+bounces-61342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 655A6823773
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AF21F25E5F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21191DA34;
	Wed,  3 Jan 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzCV7gfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6E1DA2F
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 22:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A5FC433C7;
	Wed,  3 Jan 2024 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319604;
	bh=fn1ZKyd2EbYPteASQzlt4fdLv2r9kuTIdCXksth20KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MzCV7gfYNvxpvpMJTYfq78CLMp0ba3Z7T84B9T44+lelL0BtYcGcFcSYKawA5Ap5V
	 O4jYHvm6xM4UBMclS7RNk015TaC1fWLxYJ+twxjet1zyp+yKiz8UQcaV6GqCmFPlPO
	 0zUlwNXHefLLY13Y/wd4z8EofcnYkNe3MrlwYaizTq9MapiaPcKhvI3vtFYVrBgVqN
	 9WIUCVlb/QDbs8Oi/zCNhriOKz2VUkqbl5XyrjcPi6+9GrssGSiIqlbBI3H7PnTEb3
	 qasUlOD82u4apaiHSeIrfmjNlKR24TSSMekAKD9/QchfZ1cJeqgoJYBBNmGEIPj7xh
	 Ha3xs/4IrFntg==
Date: Wed, 3 Jan 2024 14:06:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: move phylink_pcs_neg_mode() into
 phylink.c
Message-ID: <20240103140642.575fe468@kernel.org>
In-Reply-To: <E1rKhg1-00EnlX-NI@rmk-PC.armlinux.org.uk>
References: <E1rKhg1-00EnlX-NI@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jan 2024 16:31:37 +0000 Russell King (Oracle) wrote:
> +}
> +
> +

checkpatch spots multiple blank lines

>  static void phylink_major_config(struct phylink *pl, bool restart,
-- 
pw-bot: cr

