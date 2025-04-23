Return-Path: <netdev+bounces-185141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF2A98AF6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37E0163CD4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72221624D2;
	Wed, 23 Apr 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sWEUt5bx"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303E57C93
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414893; cv=none; b=A/kkEElSQo/K/BjGjO8M6qMGYyHDFB5QxOvuAK7qv+Td6sgH3AKc6xtIxUMEJFzGCyzrl5outu2GGRur4pv66rVsV7bHEd3u9IvHBXgY2wnNeJqr8ttA2pWvm+u6DvFQhrBPyhilfWMPCdHBpjMfcHhQw1slRaCcup72Vch1aco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414893; c=relaxed/simple;
	bh=t7Ljh2fsaqbgiYNNklCHJwSZJYUks6kjU9w+6x90psE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcCDx2zqHl3tuYiQGM1Ym5IGmoCcI6LW+NASRKq3UPSSXrh8FROZO2aPQHWufH3zQQDs2cmut6jRmUX7pvqICA4k2qtRa6GSII0Rh5VJY7a4Yz+hC+YawUmiQNd7SMDV5sKPXPxOkOoieAgvbKpm3w+jld03sjPUUFNqELQ0q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sWEUt5bx; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=B++KzhZD1hZ94nLm6jnC9mv0FoUvqe7Ji15IuTr4mzU=; t=1745414891;
	x=1745846891; b=sWEUt5bxdjAf2Lffqeg22cXLhMurKcGaH0T6Cc9ywkYcbiIhaoX/UXZXhyCJx
	OHCalScZ1gsT92tRqtezw8yk9fTqx6gdCJSt5jakFk3U2QWVoPsw+kYRhH6jGJqf5DPYHMsCpswq9
	alkHpgdHSdhyQuvLggWR5d2cH7xbWWKqLlf8sU1DWDOhi88OrqvZfrU3P9vtuPrEvICy0eXB9ieTu
	JOVh8mDQfp6wU1APWXGHtepuhq5eO73BP7kjxgXYkry6wst2ZOfA//9R6B0TO1j5PFoSWVo5lEHGS
	R6TJJ95B3SnxUCpBmBSXK2RYovWwi41GvtRpymbsmmTUIG8ABg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1u7a92-002Wlv-0H;
	Wed, 23 Apr 2025 15:28:08 +0200
Message-ID: <59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info>
Date: Wed, 23 Apr 2025 15:28:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl: add missing header deps
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>, donald.hunter@gmail.com,
 jacob.e.keller@intel.com
References: <20250418234942.2344036-1-kuba@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250418234942.2344036-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1745414891;d235b3db;
X-HE-SMSGID: 1u7a92-002Wlv-0H

On 19.04.25 01:49, Jakub Kicinski wrote:
> Various new families and my recent work on rtnetlink missed
> adding dependencies on C headers. If the system headers are
> up to date or don't include a given header at all this doesn't
> make a difference. But if the system headers are in place but
> stale - compilation will break.
> 
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sample")
> Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-7390
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Lo! I ran into a ynl build error today and I wonder if I'm doing
something wrong or if something is wrong with this or an related patch
that recently landed in -next.

I'm building -next rpms daily for Fedora using a .spec file that is
pretty close to the one Fedora uses. Everything worked fine yesterday,
when this patch showed up in -next. Today's build failed like this:

"""
+ pushd tools/net/ynl
~/build/BUILD/kernel-next-20250423/linux-6.15.0-0.0.next.20250423.130.vanilla.fc40.x86_64/tools/net/ynl ~/build/BUILD/kernel-next-20250423/linux-6.15.0-0.0.next.20250423.130.vanilla.fc40.x86_64
+ export PIP_CONFIG_FILE=/tmp/pip.config
+ PIP_CONFIG_FILE=/tmp/pip.config
+ cat
+ CFLAGS='-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection  '
+ LDFLAGS='-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes '
+ EXTRA_CFLAGS='-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection  '
+ /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection   ' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes ' -s -j32 DESTDIR=/builddir/build/BUILDROOT/kernel-6.15.0-0.0.next.20250423.130.vanilla.fc40.x86_64 install
	GEN devlink-user.c
[...]
	CC ethtool-user.o
In file included from ovpn-user.h:12,
                 from ovpn-user.c:8:
/usr/include/linux/ovpn.h:14:6: error: redeclaration of â€˜enum ovpn_cipher_algâ€™
   14 | enum ovpn_cipher_alg {
      |      ^~~~~~~~~~~~~~~
In file included from <command-line>:
./../../../../include/uapi//linux/ovpn.h:14:6: note: originally defined here
   14 | enum ovpn_cipher_alg {
      |      ^~~~~~~~~~~~~~~
/usr/include/linux/ovpn.h:15:9: error: redeclaration of enumerator â€˜OVPN_CIPHER_ALG_NONEâ€™
   15 |         OVPN_CIPHER_ALG_NONE,
      |         ^~~~~~~~~~~~~~~~~~~~
./../../../../include/uapi//linux/ovpn.h:15:9: note: previous definition of â€˜OVPN_CIPHER_ALG_NONEâ€™ with type â€˜enum ovpn_cipher_algâ€™
   15 |         OVPN_CIPHER_ALG_NONE,
      |         ^~~~~~~~~~~~~~~~~~~~
/usr/include/linux/ovpn.h:16:9: error: redeclaration of enumerator â€˜OVPN_CIPHER_ALG_AES_GCMâ€™
   16 |         OVPN_CIPHER_ALG_AES_GCM,
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./../../../../include/uapi//linux/ovpn.h:16:9: note: previous definition of â€˜OVPN_CIPHER_ALG_AES_GCMâ€™ with type â€˜enum ovpn_cipher_algâ€™
   16 |         OVPN_CIPHER_ALG_AES_GCM,
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/ovpn.h:17:9: error: redeclaration of enumerator â€˜OVPN_CIPHER_ALG_CHACHA20_POLY1305â€™
   17 |         OVPN_CIPHER_ALG_CHACHA20_POLY1305,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./../../../../include/uapi//linux/ovpn.h:17:9: note: previous definition of â€˜OVPN_CIPHER_ALG_CHACHA20_POLY1305â€™ with type â€˜enum ovpn_cipher_algâ€™
   17 |         OVPN_CIPHER_ALG_CHACHA20_POLY1305,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[...]
"""

Full log (with a lot more similar errors):
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-40-x86_64/08955038-next-next-all/builder-live.log.gz

I wondered why this started to happen today instead of yesterday --
and it turns out that's because the build approach I use installed the
kernel-headers package (the one that contains the files that end up in 
/usr/include/ ) from yesterday -next build. So I guess the same problem
could happen to other people as well once they install new enough 
headers; at the same time I wonder if the kernel.spec file from Fedora
is doing something wrong/stupid that causes this problem to happen.

Does anyone know why this problem occurs? If not I guess I have to
investigate myself, but I thought it was worth asking here first.

Ciao, Thorsten


>  tools/net/ynl/Makefile.deps | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 385783489f84..8b7bf673b686 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -20,15 +20,18 @@ CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
>  	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
>  	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
>  CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
> +CFLAGS_lockd_netlink:=$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
>  CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
>  CFLAGS_net_shaper:=$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h)
>  CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
>  CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
>  CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
>  CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> +CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
>  CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> -CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> +CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
>  CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
>  CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)


