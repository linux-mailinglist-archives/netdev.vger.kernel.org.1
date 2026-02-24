Return-Path: <netdev+bounces-260396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK29GYtfnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B467F1838CD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891CD3011BF3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0142C21EC;
	Tue, 24 Feb 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df4+jp0l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EA46B5
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921223; cv=none; b=eRbOI7GutqIP9RNi3U1Qb/qmz3lQQed6CqgR0EKCxUfD/rcAOUmqXYfGXcP0oroRr0Oj0L9dnjdzHIgcwc7P7s26HJnLOzQup+SAR5gq3xWPHNRtiRcgIEIxVW44HAAKJePJ+K42g0eKvXT5PudX67OBfd6RKFHGOaKyIRqpoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921223; c=relaxed/simple;
	bh=vc2/Zx/lrYf4qKoRckwGCOkcVJNGdfTsDsZn7VP7Vw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agLxCjkiYW9DOSclOfcH0TlUJyTqbSH7fN+OYuSp4fg2QiH+qtnxghojtd0nmDqKVCW7p/JNt50aeK9vPPA3IWl5XRTO17HVS4cg1/Z2512tXJQqKNco4v/aX6WABQ4EfTo37f2La7pb1omgO9UQpY7LHjXvRcz3Uoy0E0CipjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df4+jp0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD91C116D0;
	Tue, 24 Feb 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921222;
	bh=vc2/Zx/lrYf4qKoRckwGCOkcVJNGdfTsDsZn7VP7Vw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=df4+jp0lbuV+uVB6SMq9uAlLGgEQAi9EeMQ/WDw/1ykVq809q6vmNxTYGkxUtg0Jd
	 iH0ARwSDPs7nhOBLM83idVaNh5MRqrGwz06iIYApeO2XZGOa4A/7Ch4Es02QIIQFRI
	 FBs6ezcj54MLXA25Wcp2FBYGymQWrl32tzMIqOnKmkDv2f2mlumvTkYo61x0F1oqp8
	 YH8ZaxdoZ830o5X86wgXTmpeDaNXErrBCM+KYVN6/2BGtb9Ff4PbaGosZ3c2lP0Snw
	 UEFK539iZNjiBfNaXQugpzCwWCQvzRwjhPdGIPoC3YxDWPIZpcbhCnAlTMoy8M2qVM
	 zKk73wxa0Hzrw==
Message-ID: <027d191f-f04e-4ead-a9b8-a6626e0828c1@kernel.org>
Date: Tue, 24 Feb 2026 09:20:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fs_enet: add missing kfree in _remove
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
References: <20260224015517.354145-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260224015517.354145-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B467F1838CD
X-Rspamd-Action: no action



Le 24/02/2026 à 02:55, Rosen Penev a écrit :
> The kfree is present in _probe on failure but not in remove.

Which kfree ? Which structure ?

Provide more details in the commit message.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index d3c772ed5fc9..ee2b7e8866ee 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -1008,6 +1008,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
>   	dev_set_drvdata(fep->dev, NULL);
>   	phylink_destroy(fep->phylink);
>   	free_netdev(ndev);
> +	kfree(fep);

This is not correct I think. fep is allocated by alloc_etherdev() and 
released by free_netdev()

>   }
> 
>   static const struct of_device_id fs_enet_match[] = {
> --
> 2.53.0
> 
> 


