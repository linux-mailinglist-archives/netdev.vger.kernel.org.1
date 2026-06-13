Return-Path: <netdev+bounces-298990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZa1DQmNLWqohQQAu9opvQ
	(envelope-from <netdev+bounces-298990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:02:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8767F1C9
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c6KYJm4q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298990-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298990-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15CE43002B49
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D502741B6;
	Sat, 13 Jun 2026 17:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E3263C8F;
	Sat, 13 Jun 2026 17:01:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370114; cv=none; b=s42fBJW0z1e/tqhmloK4Fl7BUy9sTOVxcidR3BR4wHVb5EbhWZsuR/MpMK813hb/AMyvET2md4W8XxypKwxzbycUC/n4OvtfKtDOQiI14+8pNwbVzdUc9SfaZiBBx2eKcJDc0k3kn/9wTyMlRNoyDVRN5pN3exVrg4GF0ot2heM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370114; c=relaxed/simple;
	bh=yJDKLFA1Ph2Zha45HdUVK6sn+l5Jt1/SEr3F2LccBP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo1uRMiwzeA4U8sKnENJjS4IJyXhUy1m3yIGA/JaE3od+L0kbM7X9DIiVkVZsMl9Vd3x4o0ogX4BJt2XPQtDsimrTlaNoAWQPNiLgCgDwbVme8Fje0BTie8WO5dk5IbCzKrNfyEo440iGXbLlo/IfH+xgiL66R3pUEVw/Lynsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6KYJm4q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEA1F000E9;
	Sat, 13 Jun 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781370112;
	bh=oPKyfrz141Tt/TUVM+/cWb8Z6XMeYrBxouM0z8CDeFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6KYJm4qP8vmcje05HvxXO+iTknpptLKYFjE/ojivHJWQrr/+C4Mm7p3NsrDEIj6C
	 WJjvuGTzyZdIHo+IFt5V5BKgVrrbGuCJvuYz6GAKUzSlRQrjzT+NorGEsVwRAYbmVo
	 jwJ4L+Trz64YDVZz4X1/VuzqEP644NZ41LSs4wgUGyWIV4VTMEgqaj7ZPUyAjMIxnp
	 D0SNnrKEERtyqcgihlDIWo8EFaOlIVhW9Mey1qNdo6Kw5+ZtswIzpaMxmIr9bND3TU
	 7KNAan921Wvz37zAk348Frv7vvYOruJWNwdl/tiMxKulmog/o8KSqy48VNRx5w548C
	 /UzvrC+Hb7c0w==
Date: Sat, 13 Jun 2026 13:01:43 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: xur@google.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org, llvm@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: correcting section tags for .init and .exit
 data/functions
Message-ID: <20260613170143.GB3152432@ax162>
References: <20260612162257.896792-1-xur@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612162257.896792-1-xur@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xur@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:afaerber@suse.de,m:mani@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:maze@google.com,m:yuehaibing@huawei.com,m:jlayton@kernel.org,m:kees@kernel.org,m:fmancera@suse.de,m:gustavoars@kernel.org,m:sd@queasysnail.net,m:masahiroy@kernel.org,m:nicolas.schier@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-actions@lists.infradead.org,m:llvm@lists.linux.dev,m:lkp@intel.com,m:willemdebruijnkernel@gmail.com,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298990-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[nathan@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,suse.de,huawei.com,queasysnail.net,linux.dev,vger.kernel.org,lists.infradead.org,lists.linux.dev,intel.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ax162:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AD8767F1C9

Hi Rong,

On Fri, Jun 12, 2026 at 09:22:57AM -0700, xur@google.com wrote:
> From: Rong Xu <xur@google.com>
> 
> Fix modpost warnings that have surfaced during Clang's distributed ThinLTO
> builds.
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: tcp4_net_ops.llvm.4527429266264891517+0x8 (section: .data) -> tcp4_proc_init_net (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: udp4_net_ops.llvm.17425824324074326067+0x8 (section: .data) -> udp4_proc_init_net (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: ping_v4_net_ops.llvm.5641696707737373282+0x8 (section: .data) -> ping_v4_proc_init_net (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: if6_proc_net_ops.llvm.7870945277386035298+0x8 (section: .data) -> if6_proc_net_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: ipv6_addr_label_ops.llvm.5745897517271459135+0x8 (section: .data) -> ip6addrlbl_net_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: ndisc_net_ops.llvm.8806210167060761094+0x8 (section: .data) -> ndisc_net_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: raw6_net_ops.llvm.3743523335772203324+0x8 (section: .data) -> raw6_init_net (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: igmp6_net_ops.llvm.7071106350580158050+0x8 (section: .data) -> igmp6_net_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: tcpv6_net_ops.llvm.17505177970592326146+0x8 (section: .data) -> tcpv6_net_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: ip6_flowlabel_net_ops.llvm.6051723423336054316+0x8 (section: .data) -> ip6_flowlabel_proc_init (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: ipv6_proc_ops.llvm.7829948594772821810+0x8 (section: .data) -> ipv6_proc_init_net (section: .init.text)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606111233.kM8oo8Df-lkp@intel.com/
> Signed-off-by: Rong Xu <xur@google.com>

Thanks for sending this change to try and clear up those new warnings
from the distributed ThinLTO build. Based on the build reports that
appear from this change downthread, it does not seem like it is quite
right. Additionally, I think the commit message could be a little more
descriptive around the root cause of the warnings and how this patch
actually addresses it (I can infer but I think that information should
be up front and center).

> ---
>  net/ipv4/ping.c          |  6 +++---
>  net/ipv4/tcp_ipv4.c      |  6 +++---
>  net/ipv4/udp.c           |  6 +++---
>  net/ipv6/addrconf.c      |  6 +++---
>  net/ipv6/addrlabel.c     |  6 +++---
>  net/ipv6/ip6_flowlabel.c |  6 +++---
>  net/ipv6/mcast.c         | 10 +++++-----
>  net/ipv6/ndisc.c         | 10 +++++-----
>  net/ipv6/proc.c          |  6 +++---
>  net/ipv6/raw.c           |  6 +++---
>  net/ipv6/tcp_ipv6.c      |  6 +++---
>  11 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index d36f1e273fde..1dda6d661ad8 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -1144,17 +1144,17 @@ static void __net_exit ping_v4_proc_exit_net(struct net *net)
>  	remove_proc_entry("icmp", net->proc_net);
>  }
>  
> -static struct pernet_operations ping_v4_net_ops = {
> +static struct pernet_operations ping_v4_net_ops __net_initdata = {
>  	.init = ping_v4_proc_init_net,
>  	.exit = ping_v4_proc_exit_net,
>  };
>  
> -int __init ping_proc_init(void)
> +int __net_init ping_proc_init(void)
>  {
>  	return register_pernet_subsys(&ping_v4_net_ops);
>  }
>  
> -void ping_proc_exit(void)
> +void __net_exit ping_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&ping_v4_net_ops);
>  }
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..9caca5879466 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3317,17 +3317,17 @@ static void __net_exit tcp4_proc_exit_net(struct net *net)
>  	remove_proc_entry("tcp", net->proc_net);
>  }
>  
> -static struct pernet_operations tcp4_net_ops = {
> +static struct pernet_operations tcp4_net_ops __net_initdata = {
>  	.init = tcp4_proc_init_net,
>  	.exit = tcp4_proc_exit_net,
>  };
>  
> -int __init tcp4_proc_init(void)
> +int __net_init tcp4_proc_init(void)
>  {
>  	return register_pernet_subsys(&tcp4_net_ops);
>  }
>  
> -void tcp4_proc_exit(void)
> +void __net_exit tcp4_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&tcp4_net_ops);
>  }
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 70f6cbd4ef73..87f4cced2114 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3600,17 +3600,17 @@ static void __net_exit udp4_proc_exit_net(struct net *net)
>  	remove_proc_entry("udp", net->proc_net);
>  }
>  
> -static struct pernet_operations udp4_net_ops = {
> +static struct pernet_operations udp4_net_ops __net_initdata = {
>  	.init = udp4_proc_init_net,
>  	.exit = udp4_proc_exit_net,
>  };
>  
> -int __init udp4_proc_init(void)
> +int __net_init udp4_proc_init(void)
>  {
>  	return register_pernet_subsys(&udp4_net_ops);
>  }
>  
> -void udp4_proc_exit(void)
> +void __net_exit udp4_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&udp4_net_ops);
>  }
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c9e5d3e48ab9..73d9439bd408 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4527,17 +4527,17 @@ static void __net_exit if6_proc_net_exit(struct net *net)
>  	remove_proc_entry("if_inet6", net->proc_net);
>  }
>  
> -static struct pernet_operations if6_proc_net_ops = {
> +static struct pernet_operations if6_proc_net_ops __net_initdata = {
>  	.init = if6_proc_net_init,
>  	.exit = if6_proc_net_exit,
>  };
>  
> -int __init if6_proc_init(void)
> +int __net_init if6_proc_init(void)
>  {
>  	return register_pernet_subsys(&if6_proc_net_ops);
>  }
>  
> -void if6_proc_exit(void)
> +void __net_exit if6_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&if6_proc_net_ops);
>  }
> diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
> index f4b2618446bd..50f6c1b1edaa 100644
> --- a/net/ipv6/addrlabel.c
> +++ b/net/ipv6/addrlabel.c
> @@ -340,17 +340,17 @@ static void __net_exit ip6addrlbl_net_exit(struct net *net)
>  	spin_unlock(&net->ipv6.ip6addrlbl_table.lock);
>  }
>  
> -static struct pernet_operations ipv6_addr_label_ops = {
> +static struct pernet_operations ipv6_addr_label_ops __net_initdata = {
>  	.init = ip6addrlbl_net_init,
>  	.exit = ip6addrlbl_net_exit,
>  };
>  
> -int __init ipv6_addr_label_init(void)
> +int __net_init ipv6_addr_label_init(void)
>  {
>  	return register_pernet_subsys(&ipv6_addr_label_ops);
>  }
>  
> -void ipv6_addr_label_cleanup(void)
> +void __net_exit ipv6_addr_label_cleanup(void)
>  {
>  	unregister_pernet_subsys(&ipv6_addr_label_ops);
>  }
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index b1ccdf0dc646..f6980c403c68 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -903,17 +903,17 @@ static void __net_exit ip6_flowlabel_net_exit(struct net *net)
>  	ip6_flowlabel_proc_fini(net);
>  }
>  
> -static struct pernet_operations ip6_flowlabel_net_ops = {
> +static struct pernet_operations ip6_flowlabel_net_ops __net_initdata = {
>  	.init = ip6_flowlabel_proc_init,
>  	.exit = ip6_flowlabel_net_exit,
>  };
>  
> -int ip6_flowlabel_init(void)
> +int __net_init ip6_flowlabel_init(void)
>  {
>  	return register_pernet_subsys(&ip6_flowlabel_net_ops);
>  }
>  
> -void ip6_flowlabel_cleanup(void)
> +void __net_exit ip6_flowlabel_cleanup(void)
>  {
>  	static_key_deferred_flush(&ipv6_flowlabel_exclusive);
>  	timer_delete(&ip6_fl_gc_timer);
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index d9b855d5191b..eef5bab1ee13 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -3209,12 +3209,12 @@ static void __net_exit igmp6_net_exit(struct net *net)
>  	igmp6_proc_exit(net);
>  }
>  
> -static struct pernet_operations igmp6_net_ops = {
> +static struct pernet_operations igmp6_net_ops __net_initdata = {
>  	.init = igmp6_net_init,
>  	.exit = igmp6_net_exit,
>  };
>  
> -int __init igmp6_init(void)
> +int __net_init igmp6_init(void)
>  {
>  	int err;
>  
> @@ -3231,18 +3231,18 @@ int __init igmp6_init(void)
>  	return err;
>  }
>  
> -int __init igmp6_late_init(void)
> +int __net_init igmp6_late_init(void)
>  {
>  	return register_netdevice_notifier(&igmp6_netdev_notifier);
>  }
>  
> -void igmp6_cleanup(void)
> +void __net_exit igmp6_cleanup(void)
>  {
>  	unregister_pernet_subsys(&igmp6_net_ops);
>  	destroy_workqueue(mld_wq);
>  }
>  
> -void igmp6_late_cleanup(void)
> +void __net_exit igmp6_late_cleanup(void)
>  {
>  	unregister_netdevice_notifier(&igmp6_netdev_notifier);
>  }
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index e7ad13c5bd26..3a83280db29d 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1994,12 +1994,12 @@ static void __net_exit ndisc_net_exit(struct net *net)
>  	inet_ctl_sock_destroy(net->ipv6.ndisc_sk);
>  }
>  
> -static struct pernet_operations ndisc_net_ops = {
> +static struct pernet_operations ndisc_net_ops __net_initdata = {
>  	.init = ndisc_net_init,
>  	.exit = ndisc_net_exit,
>  };
>  
> -int __init ndisc_init(void)
> +int __net_init ndisc_init(void)
>  {
>  	int err;
>  
> @@ -2027,17 +2027,17 @@ int __init ndisc_init(void)
>  #endif
>  }
>  
> -int __init ndisc_late_init(void)
> +int __net_init ndisc_late_init(void)
>  {
>  	return register_netdevice_notifier(&ndisc_netdev_notifier);
>  }
>  
> -void ndisc_late_cleanup(void)
> +void __net_exit ndisc_late_cleanup(void)
>  {
>  	unregister_netdevice_notifier(&ndisc_netdev_notifier);
>  }
>  
> -void ndisc_cleanup(void)
> +void __net_exit ndisc_cleanup(void)
>  {
>  #ifdef CONFIG_SYSCTL
>  	neigh_sysctl_unregister(&nd_tbl.parms);
> diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
> index 813013ca4e75..c59bade608cd 100644
> --- a/net/ipv6/proc.c
> +++ b/net/ipv6/proc.c
> @@ -298,17 +298,17 @@ static void __net_exit ipv6_proc_exit_net(struct net *net)
>  	remove_proc_entry("snmp6", net->proc_net);
>  }
>  
> -static struct pernet_operations ipv6_proc_ops = {
> +static struct pernet_operations ipv6_proc_ops __net_initdata = {
>  	.init = ipv6_proc_init_net,
>  	.exit = ipv6_proc_exit_net,
>  };
>  
> -int __init ipv6_misc_proc_init(void)
> +int __net_init ipv6_misc_proc_init(void)
>  {
>  	return register_pernet_subsys(&ipv6_proc_ops);
>  }
>  
> -void ipv6_misc_proc_exit(void)
> +void __net_exit ipv6_misc_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&ipv6_proc_ops);
>  }
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 3cc58698cbbd..fe399675b8fc 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -1256,17 +1256,17 @@ static void __net_exit raw6_exit_net(struct net *net)
>  	remove_proc_entry("raw6", net->proc_net);
>  }
>  
> -static struct pernet_operations raw6_net_ops = {
> +static struct pernet_operations raw6_net_ops __net_initdata = {
>  	.init = raw6_init_net,
>  	.exit = raw6_exit_net,
>  };
>  
> -int __init raw6_proc_init(void)
> +int __net_init raw6_proc_init(void)
>  {
>  	return register_pernet_subsys(&raw6_net_ops);
>  }
>  
> -void raw6_proc_exit(void)
> +void __net_exit raw6_proc_exit(void)
>  {
>  	unregister_pernet_subsys(&raw6_net_ops);
>  }
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 36d75fb50a70..d0737f16076b 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2335,12 +2335,12 @@ static void __net_exit tcpv6_net_exit(struct net *net)
>  	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
>  }
>  
> -static struct pernet_operations tcpv6_net_ops = {
> +static struct pernet_operations tcpv6_net_ops __net_initdata = {
>  	.init	    = tcpv6_net_init,
>  	.exit	    = tcpv6_net_exit,
>  };
>  
> -int __init tcpv6_init(void)
> +int __net_init tcpv6_init(void)
>  {
>  	int ret;
>  
> @@ -2378,7 +2378,7 @@ int __init tcpv6_init(void)
>  	goto out;
>  }
>  
> -void tcpv6_exit(void)
> +void __net_exit tcpv6_exit(void)
>  {
>  	unregister_pernet_subsys(&tcpv6_net_ops);
>  	inet6_unregister_protosw(&tcpv6_protosw);
> 
> base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
> 

-- 
Cheers,
Nathan

