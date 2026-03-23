Return-Path: <netdev+bounces-270573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG4SIblUwWlVSQQAu9opvQ
	(envelope-from <netdev+bounces-270573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:56:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9722F57CE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50BEE301B4C6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610039A805;
	Mon, 23 Mar 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbR+fwx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CD235C01;
	Mon, 23 Mar 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277735; cv=none; b=rgInouA6aKKVFcD29aAdnoEJAd0cTLcGamcD/sYka6xNAHeXkr/j+0ZfFC5Ki27aNnIjaEPO0HwGErBEXT84Ok4iq2iIdAMYspETwhV1HU7VnpkhHWt85ZoXssNttKgpGmXKxse+KhrAEIkUeZCpTpx6SykLe+cgiPae6r4rNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277735; c=relaxed/simple;
	bh=eC5dKOhfv3tM26c76oHQixo2c9kv+yNRkIuS6+HVk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BunVLgbrY7s6o5OP8EACgRJHTk62fGj6TWxHa14TesQutu0dm3fa0/79ZxcVJBJCUzt7wzfwMgkSwPkKhmKMRck4S4Q8LNTDpv3dzORwYCu2bEJDrHtiyfsWWgTyWnKD9oLquzMxh8rCeRJgbUFMCleAgxqyC8+DyMTSEN6Yx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbR+fwx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E0FC2BCB4;
	Mon, 23 Mar 2026 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774277735;
	bh=eC5dKOhfv3tM26c76oHQixo2c9kv+yNRkIuS6+HVk/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbR+fwx1yNIADU1G1Se5/S7/G1ct2S45zwf1QAiriPxcu43ysWl9YTLtZFfeYKVJ3
	 5lN8In1jKFDzMrv7fk2tHGvv4tfcVJpRedkky3g+5BgMogSpR+oKl8PtCFndofZD03
	 xzYDez1Hm+9CmD9UFXS7QKrJPtGzwmYwaaKKJiuTMgFINNn7ILAUQSUkr1zoEZpwzq
	 cixoGojKXM4rIVVDUbVyz1omUG7Z8F1E5us+UTnWTyO6BCylv4sw45+OACF+flD93p
	 WJ5fzzFZEST77VN49tg/Ji6w4Jpoa+IzkI9cicdijyAB3Hjb4QvVnyuQGugCufNVNr
	 8xsk3+rvi5Ehg==
Date: Mon, 23 Mar 2026 14:55:26 +0000
From: Simon Horman <horms@kernel.org>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, sdf@fomichev.me, me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org,
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v8 1/6] Add 25GMAC core type to dwmac_core_type
 enum
Message-ID: <20260323145526.GA94382@horms.kernel.org>
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
 <20260320211921.1202058-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320211921.1202058-2-jitendra.vegiraju@broadcom.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270573-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D9722F57CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 02:19:16PM -0700, Jitendra Vegiraju wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> The DW25GMAC is a newer ethernet MAC IP block from Synopsys that introduced
> new DMA architecure called Hyper-DMA. Define a new dwmac_core_type
> enum in include/linux/stmmac.h file.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  include/linux/stmmac.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 72febd246bdb..464f4f2e366a 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -197,6 +197,7 @@ enum dwmac_core_type {
>  	DWMAC_CORE_GMAC,
>  	DWMAC_CORE_GMAC4,
>  	DWMAC_CORE_XGMAC,
> +	DWMAC_CORE_25GMAC,
>  };

Hi Jitendra,

W=1 builds warn that this new enum value is not handled in
the switch statement in stmmac_print_actphyif()

This seems to be addressed in patch 2/6.
And I would suggest squashing this patch into that one.

-- 
pw-bot: changes-requested

