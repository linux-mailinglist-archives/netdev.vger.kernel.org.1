Return-Path: <netdev+bounces-260402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG4AJH1hnWksPQQAu9opvQ
	(envelope-from <netdev+bounces-260402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:29:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA13183AFB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B52A3004055
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11B36657C;
	Tue, 24 Feb 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNHr9FXZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786B2749E6;
	Tue, 24 Feb 2026 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921780; cv=none; b=nMDOMa3R5n9NiyuagGnTh2mq1jGreklwZJRX65KQXhOxafjJ1YQQoIu13QZwdxfah0mK4Ul/AHfWw4RCZEpUhFH4pXHxOdnTitkjNvcw1d6z6iUpWACh9ir+K66BqnaAYIurnAoPYMjGeUXaYtjOwQ0X+uplSmTcFTGT4HfMraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921780; c=relaxed/simple;
	bh=s889kssXllyZaSNT87Eq7q+8jDDE7Yxpqk+iIio+e2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdSre0DGhszJjbWlbbiNmaKFC5xYCmqUpukhDQan79X18s12QT0r9RhdmJWHLhxkm9TSaPdEEL+AT004rlTmnIdC/A0dh6OAc30cWIM0sXVAYhsdYo6LEt2OksUdU8E6PzXqwPBCGciDQTICB9+vaw7Zi6unWBjGzIzjEC7D8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNHr9FXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C05C116D0;
	Tue, 24 Feb 2026 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921779;
	bh=s889kssXllyZaSNT87Eq7q+8jDDE7Yxpqk+iIio+e2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SNHr9FXZ68PnehoZL3L7xEXBRGUdm+0EhLsocHU+9tirzHDCoLqN3V2QCmwM00mFp
	 56eX4kO7yFSccVeMpCCHciajM3Exp8jX0CTK437GW390X7hsqkFXgOMqHpzSo9dwOr
	 gAWupmJ7IajiuRhF2F2wvCsyzFNkCXYWPJYSqlW0sxBoOO7rXoeWr/Lrd7Pi+rlqaN
	 uBwxTs8OpkFlRcTp7R8Fk4g1NXn7uLLvkQySG7lSr0UvbIGBeeebslLmBC16yR0B+K
	 ypauaUdj+Vw7FA8SQSuJZm+95Wy19zR4mLaCokOhS0Hp6PJmuRilzyiPWckoq9+kgV
	 Czu3m3TQWWTwA==
Message-ID: <ff1c77b9-bb29-48f8-b942-6ace8ea31dd1@kernel.org>
Date: Tue, 24 Feb 2026 09:29:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: fs_enet: allow nvmem to override MAC
 address
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260224014607.353378-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260224014607.353378-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAA13183AFB
X-Rspamd-Action: no action



Le 24/02/2026 à 02:46, Rosen Penev a écrit :
> NVMEM typically loads after the ethernet driver and
> of_get_ethdev_address returns -EPROBE_DEFER. return in such a case to
> allow NVMEM to work.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index 2cbcc29408e3..d3c772ed5fc9 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -951,7 +951,9 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	spin_lock_init(&fep->lock);
>   	spin_lock_init(&fep->tx_lock);
> 
> -	of_get_ethdev_address(ofdev->dev.of_node, ndev);
> +	ret = of_get_ethdev_address(ofdev->dev.of_node, ndev);
> +	if (ret == -EPROBE_DEFER)
> +		goto out_cleanup_data;

What about other error cases ? Shouldn't it exit on all types of errors ?

> 
>   	ret = fep->ops->allocate_bd(ndev);
>   	if (ret)
> --
> 2.53.0
> 
> 


