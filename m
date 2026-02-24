Return-Path: <netdev+bounces-260631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAs0AYf0nWk2SwQAu9opvQ
	(envelope-from <netdev+bounces-260631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:57:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340F18B9CD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D17630BFD68
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B12DE709;
	Tue, 24 Feb 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqTIX32u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10C2E0938
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959421; cv=none; b=dc0v5WsPBwRzE4K1tq8RTH5ZHj3Iab0oDzaN0I70qBTRySO5TQ5bH2E+v1s6+yXcjffG2GEg758oPELbLy4qnhYFiRHGSqZuEXJky+qIs0Na87gF2WBlVVLenQjdGU2UbD2pbpa4PQOTSgdg6AjatBsajEwmGaHeclwUZ8G5mhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959421; c=relaxed/simple;
	bh=aqBty+Czyq99RQ9yw55aktvELQ4w276GGu8ezWs0KtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfIoJss094SRlVBCYnCTnKpUfUYnShEJ+0msUf1oLqjucu9wxKhMJ2NkZLaJWSebAlml2sWu8o0/tRj7JSPcal8VMXxFYHjEqKunyWLLQ0+8iIddh6fCxoOLv4N9itRTnlIJyxxqmGMXkFH1fj85WaEVvicu6sS7lWGn7coFbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqTIX32u; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79854193a54so17781397b3.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959419; x=1772564219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXMJn9NIKlV6iRDATAc3nZwK0DNBBW/yY193mP469PU=;
        b=NqTIX32u2qNduajeoBJW69N+U+yxQrU74RGQ79RPHlCSsNrM2axFZ0hzleEArwcbJV
         V6jI5H8LkwYO8SxNveT4ickdXlMrVcKFYwxJKQYt1qtwPLrHhS+2FhR8yz7173obfdHz
         5IAVpllkw6PRDGxwq/fMuZL+0VVfGyJV0fVIQ940ng4hWolvNN50pyWbNh0plCh+BovI
         ByFffuCiE/GqJUAbTorAdDawBd5/HlPndskGlrYAEqkQGCkFNb2hUdGTUAazQ/hnilLY
         F8rpyJFT9wfss9/fqQjs8CKdeuNpHwVgO+bqHhFw+P1rLr/L2cGL9ahcppYrtCZI7FWb
         To3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959419; x=1772564219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXMJn9NIKlV6iRDATAc3nZwK0DNBBW/yY193mP469PU=;
        b=pwqSGLMIjfPwaGDC/BmjaVMzPBXK1VmKZIcxHl3OW/KK4X5sHhW1ZGFMXqZzDZn8X+
         WAVl0GUs2jo9osVAJRnOTAYZyurRe0jELpcHcy/cVJb9FensU9VdP7IsP4NaAGQeIsnh
         L6QGblxCyH0z3qvf24WhwFhv/8mNa2eWoc3DFE0nwvmc1z3OYDJ62NAzPUlUP9DuJw70
         UyLmTOoUHeA+GZibjTsunzuEAt1rVabMI5FbBkL2fcn/z25ZPiR0K+ZIAtI02HzWE8CJ
         Sh8Pn9vUHvJij1jLQJ+oRsfxkbRKHS2IxueVqcsMiS0gAW8XUNaTflVJCrqWe4Ic/ur4
         z2IQ==
X-Gm-Message-State: AOJu0YwYsjkJJ0ZASulCe8uA4eJSOm136LH7EqRmICZ6Z3c9notKQdEw
	5ly6I8X6dGBBr9HhZmXyk1Mt8Ph74sx3QGMhDhbjlWpzOkuDSdCGwuyI
X-Gm-Gg: ATEYQzzL4Xijd1PTnjEjerwgAQ8fZHkPpg+LtCoDJZ7qIGYiQ60/sIyEtHMUugvCQUr
	XLs6xtv8c1Lzj9IYmT5AcgRkajrmCIk+uRJaHjMYRImR8HuELh6b0Yf8XTKhEQVl7MB2w5OqN/r
	moz5ieRtnk6O9hA2Be3mFG5nHzcJjXdyo8TKfCLTWZ7wu4YRoWaIQ4+iwGgTQrF8+wsQAhKv33D
	Ot2Ql2n2vALixCVHpmVKrnR4AIt53YJr4zmevi65uXgDiDK2CMFD40Jx+xl0Y7d+pwpL6TNl0+f
	0z8itOkTLSh4oDz8u7o3/3auPUqsHSWeYOhPo78xdWdnnxujdS6O63ueH5Zs1ZUQRFSUkfjIPyM
	GsMp2NUEtSsIlKbkBfEmEcQGUS74s6dBGyTb95ZhhCNiJIv+FG1aVlqFEqSuP/tCNzUvIuIf/LI
	72PuqMXVTCsKwmhtgEYSSfSuMfwcTmFEZ9ZOaS3hOJh5gs8/YJ4aZMLv6Eig==
X-Received: by 2002:a05:690c:7407:b0:796:6784:82cb with SMTP id 00721157ae682-79828cf92camr123136427b3.2.1771959418733;
        Tue, 24 Feb 2026 10:56:58 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db8f90csm47065047b3.10.2026.02.24.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:56:58 -0800 (PST)
Date: Tue, 24 Feb 2026 10:56:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Wei Wang <weibunny@fb.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 8/9] selftests/net: Add bpf skb forwarding
 program
Message-ID: <aZ30eP/ZCm7NJXVh@devvm11784.nha0.facebook.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
 <20260224002410.1553838-9-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224002410.1553838-9-weibunny@fb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 7340F18B9CD
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:24:08PM -0800, Wei Wang wrote:
> Add nk_redirect.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified dev ifindex.
> bpf_redirect_neigh() is used to make sure neighbor lookup is performed
> and proper MAC addr is being used.
> 
> Signed-off-by: Wei Wang <weibunny@fb.com>
> ---
>  .../drivers/net/hw/nk_redirect.bpf.c          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
> new file mode 100644
> index 000000000000..7ac9ffd50f15
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BPF program for redirecting traffic using bpf_redirect_neigh().
> + * Unlike bpf_redirect() which preserves L2 headers, bpf_redirect_neigh()
> + * performs neighbor lookup and fills in the correct L2 addresses for the
> + * target interface. This is necessary when redirecting across different
> + * device types (e.g., from netdevsim to netkit).
> + */
> +#include <linux/bpf.h>
> +#include <linux/pkt_cls.h>
> +#include <linux/if_ether.h>
> +#include <linux/ipv6.h>
> +#include <linux/in6.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define TC_ACT_OK 0
> +#define ETH_P_IPV6 0x86DD
> +
> +#define ctx_ptr(field)		((void *)(long)(field))
> +
> +#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
> +				 a.s6_addr32[1] == b.s6_addr32[1])
> +
> +volatile __u32 redirect_ifindex;
> +volatile __u8 ipv6_prefix[16];
> +
> +SEC("tc/ingress")
> +int tc_redirect(struct __sk_buff *skb)
> +{
> +	void *data_end = ctx_ptr(skb->data_end);
> +	void *data = ctx_ptr(skb->data);
> +	struct in6_addr *match_prefix;
> +	struct ipv6hdr *ip6h;
> +	struct ethhdr *eth;
> +
> +	match_prefix = (struct in6_addr *)ipv6_prefix;
> +
> +	if (skb->protocol != bpf_htons(ETH_P_IPV6))
> +		return TC_ACT_OK;
> +
> +	eth = data;
> +	if ((void *)(eth + 1) > data_end)
> +		return TC_ACT_OK;
> +
> +	ip6h = data + sizeof(struct ethhdr);
> +	if ((void *)(ip6h + 1) > data_end)
> +		return TC_ACT_OK;
> +
> +	if (!v6_p64_equal(ip6h->daddr, (*match_prefix)))
> +		return TC_ACT_OK;
> +
> +	/*
> +	 * Use bpf_redirect_neigh() to perform neighbor lookup and fill in
> +	 * correct L2 addresses for the target interface.
> +	 */
> +	return bpf_redirect_neigh(redirect_ifindex, NULL, 0, 0);
> +}
> +
> +char __license[] SEC("license") = "GPL";
> -- 
> 2.47.3
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Tested-by: Bobby Eshleman <bobbyeshleman@meta.com>

