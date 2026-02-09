Return-Path: <netdev+bounces-257876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMRBMuYwiWnk3wQAu9opvQ
	(envelope-from <netdev+bounces-257876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 01:57:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DC10AC56
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 01:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD415300146A
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 00:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CD221F2F;
	Mon,  9 Feb 2026 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeXeE23+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135432745E
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770598627; cv=none; b=qXHCMxfFYnii2yabvHvXxFZ99IrSORHvWwUc5XyJjUeQePtxftXCc9Qq4iy2FFrDFapuwBM7XPpL7UtrvcGHbyZJebLss0dYVtiNgl5aSLpl//6U8cZzdMjuP43l5LLOBnozKkd+rWnfqqntKu3wcuFtb0KH/sdU/qux559PP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770598627; c=relaxed/simple;
	bh=du5Zf+7xCB33/a5X/Wdxrz+9voAECXeFloi29ihi7ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccygBRHMZdUCLhoTL10OoIrq67w/tA+IVo5XzjHJskhpbgHLZhUeHKPbwcSnPzkSMLZTf7mYDWHcL9FcI4G2Ldw9SE5OVOTQf9QWQ0rUogyHXbD5QiAZotWhwDho3Opx1pFotp27T33HAM2xAs0TWETl/LGD5glgJJCVKVzHE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeXeE23+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1649835b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770598626; x=1771203426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylb+rGFWC7Fqd7MZ0Nu34Xr0zo2M+DhhntdKFK3XEUI=;
        b=eeXeE23+HaOLfa4pdFMJR7ynScAYA88qUa2i8YxRpahXxTuyGwrYaIYDeDe9xh9HQw
         55Vz/QmT43QF/wKqu+v2qUEi/87jGAMhx2YKhPLgTrb1dM4nB+s5sZZbza/Pu4mV1RM6
         fzYAjTceNxzFOozLTo42jrkKyhL9LJuLzDPPr6mfBjkKf/qKPw9iOyd9sJ+z7zJovLWy
         JUTOdvWkIsJSfCWZSAmWz7CaWfNGJlN53i/g4T57oQRsDyE9KXjQYgHe0q9oW+43hVR+
         +/lCAdY8CSHPAZNrQcl845KAZThsdhJLxYnff6a0eTWNw4TXXyQcCsrTzYNeSMEZ7ulU
         NQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770598626; x=1771203426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylb+rGFWC7Fqd7MZ0Nu34Xr0zo2M+DhhntdKFK3XEUI=;
        b=v0Aer+QiTUPFSY0HxfCHvtThMhuBIHXnoXKB0mhbXSPaiD2Qthend7f7u2gA2198b+
         rINao+Wib2CpHr3C3l+Dioyd4xB9lDmW8TjM3Ty4aYtlcoFXf/qEV+gSrYx0a0jA8FGj
         63TbMrPdvXZhJFhiCRjSaMgbWDSRbvgic6QvbN8FBTFuMA/2Gob2tPJbEoVBH+rvLh8T
         Obr1NI4OZwH3RNJIKtqoxZll+nOseULiTQ8UxhMcNXk10uxW84ik0W3CSLARk0evnoTU
         nbRYrGq2dU2FU4apckh/O8s++lTQDUPeu8GLnAXDcrcojVhTafmY+n3ueqeNEFJTALe4
         qiJg==
X-Forwarded-Encrypted: i=1; AJvYcCWIYdnpaxrbfyyXyDG5ZC6Anxu+DgAKzj2BbtkiPrhepiJkhm8tWAJjY0p4iR78hEjDdlEPIy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyej2g4DM/6azmf6fpL11wOK03FCEEj6H3xxwJd2vdWtP9pIxAO
	T1ssTnB9+ZrhpcyH9FP12yNAIVqZGH1YNxfxYxwvThMCv/Qliay+eHRm
X-Gm-Gg: AZuq6aKD0XAdNuV2+U9JGtL+P4SZ01O2bBLLRq75igBJsmPt7E9LtT8md0GtBHXm1Oc
	KIwTki0soe7BdXY6Vk8dZBhr3kX5KeQbC5RPT+eUA0QyeAnShdvZRX51XvDFuSKM3JW63mLU4dA
	TOoUu2eCjuPr/s3D2X0WgOdUSPsdqufCi4e5fRc518CphckaIJQcKwKWBWqeUPea8HDff5s+ng1
	a/nuJzfWv163PkgkEdBs2+5jeOw4+qNxWyOxqCFYnpaD0bUQ3vmhnauAdHGMm2Eh15/bSuGnqiI
	1bt5iG5ZkIB9e/KIvJpNpZ+5gx7Fxebz+hmTswBUDwbufZwbNQniTmvcfNVoDuKMNnQcjba4juY
	s4WLAkjoH9SFXCMcTss8V3sbsrlN0ndd8Se6ePJCscz8iJURSl+DjVzgarayieTHKbNSFdeklgq
	nwVOp+gTWdB8ZSoeo=
X-Received: by 2002:a05:6a20:7f8c:b0:38e:9405:bf03 with SMTP id adf61e73a8af0-393ad039d10mr9955892637.35.1770598626306;
        Sun, 08 Feb 2026 16:57:06 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b2253c70sm8938198a91.17.2026.02.08.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 16:57:05 -0800 (PST)
Date: Mon, 9 Feb 2026 00:56:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Linus Heckemann <git@sphalerite.org>
Cc: edumazet@google.com, davem@davemloft.net, eric.dumazet@gmail.com,
	horms@kernel.org, kuba@kernel.org, morikw2@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Subject: Re: [PATCH] selftests/net: add test for IPv4-in-IPv6 tunneling
Message-ID: <aYkw23FjhSG6qiUX@fedora>
References: <20260208144604.1550582-1-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208144604.1550582-1-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257876-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ip6_tunnel.sh:url,io_uring_zerocopy_tx.sh:url,ip6_gre_headroom.sh:url,ipv6_flowlabel.sh:url,ip_defrag.sh:url,ioam6.sh:url]
X-Rspamd-Queue-Id: 6E6DC10AC56
X-Rspamd-Action: no action

Hi Linus
On Sun, Feb 08, 2026 at 03:46:04PM +0100, Linus Heckemann wrote:
> 81c734dae203757fb3c9eee6f9896386940776bd was fine in and of itself, but

Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")'

> its backport to 6.12 (and 6.6) broke IPv4-in-IPv6 tunneling, see [1].
> This adds a self-test for basic IPv4-in-IPv6 functionality.
> 
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/
> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 41 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 45c4ea381bc36..5037a344ad826 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -43,6 +43,7 @@ TEST_PROGS := \
>  	io_uring_zerocopy_tx.sh \
>  	ioam6.sh \
>  	ip6_gre_headroom.sh \
> +	ip6_tunnel.sh \
>  	ip_defrag.sh \
>  	ip_local_port_range.sh \
>  	ipv6_flowlabel.sh \
> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/selftests/net/ip6_tunnel.sh
> new file mode 100644
> index 0000000000000..366f4c06cd6a3
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# Test that IPv4-over-IPv6 tunneling works.

Maybe tests IPv6-over-IPv6 as well?

> +
> +set -e
> +
> +setup_prepare() {
> +  ip link add transport1 type veth peer name transport2
> +
> +  ip netns add ns1

net lib has a helper setup_ns()

> +  ip link set transport1 netns ns1
> +  ip netns exec ns1 bash <<EOF
> +  set -e
> +  ip address add 2001:db8::1/64 dev transport1 nodad
> +  ip link set transport1 up
> +  ip link add link transport1 name tunnel1 type ip6tnl mode ipip6 local 2001:db8::1 remote 2001:db8::2
> +  ip address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel1
> +  ip link set tunnel1 up
> +EOF

You can use ip -n $ns_name address/link other than put all the cmds in a inner
bash.


> +
> +  ip netns add ns2
> +  ip link set transport2 netns ns2
> +  ip netns exec ns2 bash <<EOF
> +  set -e
> +  ip address add 2001:db8::2/64 dev transport2 nodad
> +  ip link set transport2 up
> +  ip link add link transport2 name tunnel2 type ip6tnl mode ipip6 local 2001:db8::2 remote 2001:db8::1
> +  ip address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel2
> +  ip link set tunnel2 up
> +EOF

Same here

> +}
> +
> +cleanup() {
> +  ip netns delete ns1
> +  ip netns delete ns2

At the same time cleanup_all_ns() help could be used.

> +  # in case the namespaces haven't been set up yet
> +  ip link delete transport1
> +}
> +
> +trap cleanup EXIT
> +setup_prepare
> +ip netns exec ns1 ping -W1 -c1 172.0.0.2
> -- 
> 2.52.0
> 

Thanks
Hangbin

