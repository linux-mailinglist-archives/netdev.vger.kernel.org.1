Return-Path: <netdev+bounces-287665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH+POxOkBGogMQIAu9opvQ
	(envelope-from <netdev+bounces-287665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51409536E8D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF2DB30492B4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1047D95C;
	Wed, 13 May 2026 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQrO/dQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF18381AFE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686362; cv=none; b=ZL03HAQ89zAAGm7JckeOTuQF0HADMkpJb1SNwKgELlYkgNPtVwtn+MBKX5CC+Mek3Pur7YzI/SBsIO9p0Z64xDq4Hf9rGrdnpr+nJ6eAtwyGGpUreDPMbeFEqWMQKreRIraobA+09R1f5xrzE2i+M6+23VRYB4/Bb0EIxYQqd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686362; c=relaxed/simple;
	bh=uEdiX3bsYBq/wVfVqaY6nIE6JvVlmP8CjNL6fk0R+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITmE7XaBwDOu0tFpq7/3leKZDQ0s6dVQWvN8AG/WsDKJdGOE0NOgBwd+0ztlGPCY6l/hcoEtsQI+gfb063tTchTxgSxZu0DOiRx1yi3g7duQRjde8QBKHroRiEMc6ArbF0a4ctnMbgiLqhvXamdlojANFiidFdupQvSIcwpzQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQrO/dQ7; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso2638398a91.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686360; x=1779291160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2C8hObdO8WpevMDGMCA7yvRyBq1XyhuobSazR5gNIQs=;
        b=hQrO/dQ75FkRUjpGtoKNrMBNsuAu5i803NBLZKR4r3tU3e6aOv+MTELV/oWyDab6qd
         BhUo6+VuEOGuuJtkDfegJMOao02B3tNm87chYCdHYs6wmQIkzRGgNmD3MPhQPo9QyQ+M
         Zol5oaIgxL6JybiDuhu4Z16nnxYr55Pe65zE4wNkpQZUx6akqwsqnut1MX+fZNSwiSK/
         Eqqe0asrCPmSTTFZwoTcKXcsCFZgQhZq3GDQ3Ml6sIjegUF5Hq0JxkKwRc/HiiEg0JZd
         U8dfxY4q29axC37VRLN9jmD83QzWeP8AjLkGhfvC4t7DXHucp4a52l3yJpl93BG+L+Pu
         3BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686360; x=1779291160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C8hObdO8WpevMDGMCA7yvRyBq1XyhuobSazR5gNIQs=;
        b=YXekH49+wEh0Arv+FnVpoVV9qKJqgzwEokDr2Nz/0iB1uNy/AWnsABI8Z4tGwp2KdH
         TjLN6gGpjE6ZRCsM/IpadtZW8oeE1ey/NQ7ec7zkiTzRNmG3zOM7l8RrLpKlw9cXGUCj
         OsVfAn/cWUll3CjFS29m/JIVjL6FFrxDqx+dLBorsPbpHAsl9VxPSBaHr8uxvX1ecdh2
         PAEq86Nb//c4OcLF066n2OqVVPIDhu883XYM9h2zCBsA3fnBqwHfJki8RqVwsyGpsPf6
         OL5M7KgS3UG71eegVH2DLAlsRtXXDTnYzHs+fiwQYA1kmQ5h93yYsotceFSzpkolmJC9
         pHuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3b7DsivX9LNF0IUJDZtEpVA1yVJ0FVuwLtFrwiy4fKedjRAVahw/4mW8o0yDvpgPaijgFJHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFK3SJHywxV7t/IIRmy/7m+kj4ssKy8HMR9/Dq39GLTHN/tY2
	zkUyRNZNtn4/CaWgoLt7vO1tL9zhw5FZUNXC5chD0LU3Di8CSM7msxAY
X-Gm-Gg: Acq92OGUWbsMM+AEO5l5MiFqR2KQQUft+zRffSaKvQMEccrRGVq0HTTYXMjsRRdcza8
	Q6LRsdpFmsYSDt1M3DYWWP92WGbyJHAHgMpgGEu9XggPTX1d1TUyYxV7IoVUtj3c8WaVcivygGt
	csgIjxkTU9sJ8xu3b+AWTpfjfgi1JIyfI/xgIvDj0ciJDGOh0c8a740a3pbOGfEVBV1dtA3OP/W
	eU9e4ojTeS2+b5FoGIIGdc78rxDAWQOqcxGOzDJ5DPURO2f5TE6LbMhmkUuAgsmfgi9eIvnNttf
	qn7WH6YB6xa4x2rfXRJdMTnPaaQOJdBeV0AdFX2vmoQl4CE9ByZmx+HLKZIutMd5QJq5p7Qc9cr
	WxE2J5mHizPEK2Uh9PLFmLKFkYv2KXPlvq9BduxvW87JJvh15CyDpRTnzbl/w0X30hK9ObOwEwk
	oMgXVxwj/D3Bvzk1kY
X-Received: by 2002:a17:90a:c105:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-368f782ef5amr3543149a91.10.1778686359919;
        Wed, 13 May 2026 08:32:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee6280d0sm3409228a91.16.2026.05.13.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:32:39 -0700 (PDT)
Date: Wed, 13 May 2026 08:32:39 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 4/6] l2tp: ppp: convert to getsockopt_iter
Message-ID: <agSZeMEvxE0xyNB8@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>
X-Rspamd-Queue-Id: 51409536E8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287665-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/13, Breno Leitao wrote:
> Convert PPPoL2TP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/l2tp/l2tp_ppp.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de2..4c7a1152b20ba 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -59,6 +59,7 @@
>  #include <linux/string.h>
>  #include <linux/list.h>
>  #include <linux/uaccess.h>
> +#include <linux/uio.h>
>  
>  #include <linux/kernel.h>
>  #include <linux/spinlock.h>
> @@ -1317,7 +1318,7 @@ static int pppol2tp_session_getsockopt(struct sock *sk,
>   * or the special tunnel type.
>   */
>  static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
> -			       char __user *optval, int __user *optlen)
> +			       sockopt_t *opt)
>  {
>  	struct sock *sk = sock->sk;
>  	struct l2tp_session *session;
> @@ -1328,9 +1329,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
>  	if (level != SOL_PPPOL2TP)
>  		return -EINVAL;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
> +	len = opt->optlen;
>  	if (len < 0)
>  		return -EINVAL;
>  
> @@ -1358,12 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
>  			goto end_put_sess;
>  	}
>  
> -	err = -EFAULT;
> -	if (put_user(len, optlen))
> -		goto end_put_sess;
> -
> -	if (copy_to_user((void __user *)optval, &val, len))
> +	opt->optlen = len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) != len) {
> +		err = -EFAULT;
>  		goto end_put_sess;
> +	}
>  
>  	err = 0;

nit: if you're moving `err = -EFAULT`, you might as well remove this
`err = 0` ?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

