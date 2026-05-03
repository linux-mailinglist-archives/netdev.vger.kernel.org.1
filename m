Return-Path: <netdev+bounces-283573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJmpI8EH92mfbQIAu9opvQ
	(envelope-from <netdev+bounces-283573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2154B4E27
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97DE3006B3C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A12DCBFC;
	Sun,  3 May 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="a4wIEfje"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E029175A7B
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797054; cv=none; b=YPcOThqbylMRBYy5CNaREjfl32kO8yWZBv9bozIdbVf38HLsgkwDJ7r2vGNvcbDLeRoN0/5mwpqKWH41sQcw8MFaB6k8oCjxAauiiMHzlSwYcZMsm1kS3l+VmXjbVh4X677VCJfuwCWlA8SRyd+fWAzuRYFMfqwwMtL4kvZCGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797054; c=relaxed/simple;
	bh=xuy7E00c+ImwnU7UKGCuTUi+YywSoQjFOGhNjkdHvk8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q3N/G2fLjLyuIL21imRxO5Hfg3iI0a/fSscy2x6XbUtsMZrwm/wRaSQl0El5YLAEGnNzB3txPAYSAKASJsB5A9/6BPSceHQNGGBDjJJkE5QhQKD02I4EcLQE1YHk0JE89+PtpuHvqnTdcoBRJFU42TzeqFZOjNEHYuS5iRx4Dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=a4wIEfje; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id C2B501FF83;
	Sun, 03 May 2026 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777797050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTOQamUfUbzlHhKbOnpJ+ZSbw2FCajFGk+eYIoB+kqs=;
	b=a4wIEfje0aR1NmV8+qvaul+10jw+p6Qq2p7sxcpFG37RG2VWQJv9F9Wfwg6PJNumOsYRad
	K+QysshPv8yBOPeyUqCqGgyGdPV3sqKjiegx2ttyHUWgaI5NTM0YYXwej2mwdULH2hdtC5
	teUqyomPjWNsGAEvRVoXtl5VRoVUKP8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 1/1] batman-adv: stop caching unowned originator
 pointers in BAT IV
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com, 
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
 wangjiexun2025@gmail.com
In-Reply-To: <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
References: <cover.1777692024.git.wangjiexun2025@gmail.com>
 <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
Date: Sun, 03 May 2026 10:30:28 +0200
Message-Id: <177779702879.645574.14368201380729825498.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=sven@narfation.org;
 h=from:subject:message-id; bh=xuy7E00c+ImwnU7UKGCuTUi+YywSoQjFOGhNjkdHvk8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf2Td2/nRtvDnhioP9nm8TFQ2jE4U/vI7vairRfSsx+
 cLq0t1rO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWbCYkeHC5ONvlkQsLj4n
 7n9J1ObUjqOnUg9u6Otcvn7dniO+7/c8Y2TYwHt49Z3L7HLGvNdfNjTfdDvbcP/kk0wGH/En4Wv
 XT//GAgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: CB2154B4E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-283573-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[narfation.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:dkim,narfation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

On Sun, 03 May 2026 12:28:58 +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> [...]
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

This looks half finished from the types perspective: 

net/batman-adv/bat_v_ogm.c:
713 |         if (router && router->orig_node != orig_node && !orig_neigh_router) {

net/batman-adv/originator.c:
697 |         neigh_node->orig_node = orig_node;

net/batman-adv/types.h:

631 |         struct batadv_orig_node *orig_node;


Not sure if __private and ACCESS_PRIVATE() would be an option - just to handle
this non-deref comparison while still allowing a fast comparison of the pointer
value.

I don't want to make this a show-stopper - just a possibility to think about
this for a moment. Especially because I am waiting for some info about the
sashiko.dev "Embargoed" state

>
>
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index f28e9cbf..168b413d 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -906,6 +899,31 @@ static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
> [ ... skip 22 lines ... ]
> +	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
> +	batadv_orig_node_put(orig_neigh);
> +
> +	return sum;
> +}
> +

@Marek, @Simon, Maybe you can also get a good cup of tea and think (besides
performance implications) think about other side effects.

-- 
Sven Eckelmann <sven@narfation.org>

