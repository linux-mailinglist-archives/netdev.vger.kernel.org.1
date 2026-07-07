Return-Path: <netdev+bounces-305575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hw7MHOJNTWrUxwEAu9opvQ
	(envelope-from <netdev+bounces-305575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:05:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81C71ED8A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=mHJcgEqT;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305575-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305575-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC1BE302BBD4
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C53A3812;
	Tue,  7 Jul 2026 19:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093DE3A16AB
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:04:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451069; cv=none; b=dqxuY0NtuP3PHM4E0C4bdwEggiLXjJuAQQTY1sN2l0q9aGqGXbdliDTDU2p46Lt7zWLJ5PH7IDrHsx53zAZQgVaQ08E9T8winCrKJfj6j0rrN6su4y5TWg026uO09ATsU0VTUOCUw/56hQgP8p1FoADhmxUzWTISrNgHM8Pr6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451069; c=relaxed/simple;
	bh=jgnZmK1VdRx3ekmhwpxasyn6+I4krYD1F/qr/XordPg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=sTBiWT115ATKWTmpWPtl2KAtOdsZsn+1FBDT8fqlMSVjA/oyjsJzjcLcoagMLRabyOI8Ti7YoodDBXK6oSKbx9hD+x5uyCs10imJqHWSmDzI3xcQHKJQhvZeasfc7xaNJcoe47d0CBz+W0EdD0s/kJntdygst4Q14QYkl7dNiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mHJcgEqT; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8483d01240bso211958b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783451067; x=1784055867; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5w4HIvRYyzA63PhZxwpLU+obOAC5dfzpHXc/SonfN+A=;
        b=mHJcgEqTVdUt6WSh1PSPjMyWmjMviJPoxW6xjlF6OFw9z4OMHuF16/udeHvfKafztr
         zOjXj3IyqIKHE53NWoTNvn3oMMsFWX93tf86+3i0NLpadH1TO1YJOKleR+gpJIc+Nk+m
         jTBXUl3YqHiHoXZtiuCh37WTxeGylJzSxJlV2JXwCOQRd9eHd5T4QRfjd7zd1vSN+u7/
         SNPVjuAAWgt2+5ZnOWmYUmKuWggpoNEaJJCbc2oyKD7NwVHPLlBgCLmuQg8yLBntrjZm
         zgNnxUlYALBLV7VSjzgBlcGVDKFB/0/CdjUSwUuW1mgc9A5vwgKIX1mgNlbuXVVVN7HY
         aIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451067; x=1784055867;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5w4HIvRYyzA63PhZxwpLU+obOAC5dfzpHXc/SonfN+A=;
        b=ljDGLS7k2IVlcYS8gxaGA9dh7cA/EqYZ0CfZEfT+Uwl+IPOQ7SqyO55d7rVp5C2aJg
         PtJx55RhKbaY0EkEyfQkZY94g/VGmk1H/mZbWQvue98L8Msq5kGLWMMlNhnWaRTFfhKu
         CfrWmuXDxxVNyPrHKww7Py4g+04c8l7q2NwvhERbHRQ1qxU0SNfUpsoixHifOz7Dinvs
         NQy041rHqVA8DRRgvEqvB2rr84zIA/LFsI6LVOCxHQ1ODXolWXSU95GCEmCukrJ7RmwW
         KXE30PphOBo2A7EM3zYc4u9WWx46k6MamNrpHejC/UTpUUwFsWMSgnAzSV4WPFREXjeU
         Azbg==
X-Forwarded-Encrypted: i=1; AHgh+RqobqG+N5rWp53o/zO0FbBXOTn8Ik5mLwUOCfGcuTFdho9RpIl9hgA2w0rAiqR3X+j61Wt1WGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFRfL/hObxZr6yD97TfoUn371VssUlfe3vf9HZkp6TVrE5oRm
	OJt/XLGKjXbrgbC2wFbpBxDWoDz+AYVLgZJKu5WvWkkg6USG2JZVxWua9K0R5KCWwq0=
X-Gm-Gg: AfdE7cmF4vnzW8PkHNFEA5jUsPQi3TX3PEfsM0mWR4nrhVRHLyrMp1vPpEE0At//3Oy
	Hws2y83k3aLTfoiA+lSKcJGwZV3uLElLzwZFHgHxH1Snk39qMc4QwS7JBj0BlvDVVqCjPAdTwuF
	T7RHA9AE7kfcCqpvrscACho8eAjmuY+A2nmw6V259853mwCyX8pE5uxTvu7nFI9qagMtFbcJZUw
	5s50yPHWf8AP8/dZWICAMdlCcT/lN3GsSPd/8jIZUoH4cOP6QjRpX9+usDI6r+Iq38ggFDxBMLS
	2mO2f23GyE7gdo3r+w9aerEU7jbmT4yiqG+5HqPTEEWquIW0ZXOeJKUvrd22OqaYgsTjd9qRUsx
	ZDcm2X/cIDKLPVkFdtAo+WxhMh6Nbe4d+SJgdpCAEd2q0K8/VqrIi8AxvqKsDdlL/x/9ySuRNeW
	/KTMvR35Gre2tAZm6TTeYXvWNEwYcWO8eA2tdLSqNiqg==
X-Received: by 2002:a05:6a00:430a:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84826bca450mr6248982b3a.25.1783451067279;
        Tue, 07 Jul 2026 12:04:27 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a98asm5882783b3a.42.2026.07.07.12.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 12:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 15:04:25 -0400
Message-Id: <DJSKN0TVIESF.1RVIJ8SRZRRBE@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add bpf_fib_lookup()
 VLAN flag tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
 <hawk@kernel.org>, <yatsenko@meta.com>, <leon.hwang@linux.dev>,
 <kpsingh@kernel.org>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <eyal.birger@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <toke@redhat.com>, <dsahern@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
 <20260704092159.1256823-4-avinash.duduskar@gmail.com>
In-Reply-To: <20260704092159.1256823-4-avinash.duduskar@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF81C71ED8A

On Sat Jul 4, 2026 at 5:21 AM EDT, Avinash Duduskar wrote:
> Cover both new VLAN flags in the fib_lookup test. BPF_FIB_LOOKUP_VLAN
> reduces a VLAN egress to its physical parent plus the tag, and
> BPF_FIB_LOOKUP_VLAN_INPUT scopes the lookup to a VLAN subinterface.
>
> BPF_FIB_LOOKUP_VLAN is XDP-only, since VLAN devices have no XDP xmit; the
> tc helper rejects it with -EINVAL, which the table runner asserts for
> every flag arm, and the egress result is checked through
> bpf_xdp_fib_lookup(). Non-VLAN cases run through both helpers and assert
> the path-independent results match; the XDP loop also checks dmac and,
> for the tot_len cases, the route mtu_result, so the VLAN-egress dmac and
> frag-needed coverage stays even though the tc path no longer reaches it.
>
> The egress arms pin the reduction (parent ifindex plus tag, including
> via a neighbour on the VLAN device, in OUTPUT mode, over a bond, and
> through a DIRECT|TBID table) and the failure contract: a stacked-VLAN
> (QinQ) egress returns BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex
> left at the input. That is distinct from a no-neighbour return, which
> reports the egress ifindex; only VLAN_FAILURE rewinds params->ifindex,
> and a guard arm whose input and egress devices differ pins the
> distinction. The VLAN_FAILURE arms are IPv4; the IPv6 path reaches it
> through the same shared code, so an IPv6 arm would only re-test that.
>
> The input arms use an iif rule that routes one destination to two
> gateways, so the asserted gateway reveals which device the lookup used
> as ingress, including VRF table selection through the l3mdev rule and
> l3mdev_fib_table_rcu(). A cross-netns subtest moves a VLAN device into a
> second netns while it stays registered on its parent and checks both
> directions fail closed at the boundary.
>
> A live-frames subtest (test_fib_lookup_vlan_redirect, with
> BPF_F_TEST_XDP_LIVE_FRAMES) drives real frames through the native
> xdp_do_redirect() / xdp_do_flush() path: a reducible egress is
> redirected to the parent and delivered to its peer, while a QinQ egress
> is passed to the stack, since redirecting to the VLAN device would drop
> the frame at flush (no ndo_xdp_xmit).
>
> The remaining per-case assertions are in the test table: resolution
> semantics, the -EINVAL and NOT_FWDED error arms, and the SRC/SKIP_NEIGH
> combinations.
>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit below.

> ---
>  .../selftests/bpf/prog_tests/fib_lookup.c     | 712 +++++++++++++++++-
>  .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
>  2 files changed, 744 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/=
testing/selftests/bpf/prog_tests/fib_lookup.c
> index bd7658958004..18b6fdeca382 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c

<SNIP>

> +#define VLAN_ID			100
> +#define VLAN_IFACE		"veth1.100"
> +#define VLAN_ID_DOWN		102
> +#define VLAN_IFACE_DOWN		"veth1.102"
> +#define QINQ_OUTER_IFACE	"veth1.200"
> +#define QINQ_INNER_IFACE	"veth1.200.300"
> +#define VLAN_TABLE		"300"
> +#define IPV4_VLAN_IFACE_ADDR	"10.5.0.254"
> +#define IPV4_VLAN_EGRESS_DST	"10.5.0.2"
> +#define IPV4_QINQ_DST		"10.7.0.2"
> +#define IPV4_VLAN_DST		"10.6.0.2"
> +#define IPV4_VLAN_GW		"10.5.0.1"
> +#define IPV6_VLAN_IFACE_ADDR	"fd02::254"
> +#define IPV6_VLAN_EGRESS_DST	"fd02::2"
> +#define IPV6_VLAN_DST		"fd03::2"
> +#define IPV6_VLAN_GW		"fd02::1"
> +#define VLAN_VID_UNUSED		999
> +#define VRF_IFACE		"vrf-blue"
> +#define VRF_TABLE		"1000"
> +#define VRF_VLAN_ID		101
> +#define VRF_VLAN_IFACE		"veth1.101"
> +#define IPV4_VRF_IFACE_ADDR	"10.8.0.254"
> +#define IPV4_VRF_GW		"10.8.0.1"
> +#define IPV4_VRF_DST		"10.9.0.2"
> +#define TBID_VLAN_ID		50
> +#define TBID_VLAN_IFACE		"veth2.50"
> +#define IPV4_TBID_VLAN_DST	"172.2.0.2"
> +#define IPV4_BOND_VLAN_DST	"10.11.0.2"
> +#define IPV4_VLAN_MTU_DST	"10.5.9.2"
> +#define QINQ_AD_VLAN_ID		200
> +#define QINQ_INNER_VLAN_ID	300
> +#define BOND_IFACE		"bond99"
> +#define BOND_PORT		"veth3"
> +#define BOND_PORT_PEER		"veth4"
> +#define BOND_VLAN_ID		500
>  #define DMAC			"11:11:11:11:11:11"
>  #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
>  #define DMAC2			"01:01:01:01:01:01"


Here we add a bunch of shorthands for the topology we're setting up,
but not for all interfaces/IPs. E.g.,

<SNIP>

> +/*
> + * A VLAN device can be moved to another netns while staying registered
> + * on its parent. Neither direction may then cross the boundary: the
> + * egress flag must not publish the foreign parent's ifindex, and the
> + * input flag must fail closed rather than use a foreign ingress.
> + */
> +void test_fib_lookup_vlan_netns(void)
> +{
> +	struct bpf_fib_lookup *fib_params;
> +	struct nstoken *nstoken =3D NULL;
> +	struct __sk_buff skb =3D { };
> +	struct fib_lookup *skel =3D NULL;
> +	int prog_fd, xdp_fd, err, parent_idx, vlan_idx;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, run_opts,
> +		    .data_in =3D &pkt_v6,
> +		    .data_size_in =3D sizeof(pkt_v6),
> +		    .ctx_in =3D &skb,
> +		    .ctx_size_in =3D sizeof(skb),
> +	);
> +	LIBBPF_OPTS(bpf_test_run_opts, xdp_opts,
> +		    .data_in =3D &pkt_v6,
> +		    .data_size_in =3D sizeof(pkt_v6),
> +	);
> +
> +	skel =3D fib_lookup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		return;
> +	prog_fd =3D bpf_program__fd(skel->progs.fib_lookup);
> +	xdp_fd =3D bpf_program__fd(skel->progs.fib_lookup_xdp);
> +	fib_params =3D &skel->bss->fib_params;
> +
> +	SYS(fail, "ip netns add %s", NS_VLAN_A);
> +	SYS(fail, "ip netns add %s", NS_VLAN_B);
> +
> +	nstoken =3D open_netns(NS_VLAN_A);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns(a)"))
> +		goto fail;
> +
> +	SYS(fail, "ip link add veth7 type veth peer name veth8");
> +	SYS(fail, "ip link set dev veth7 up");
> +	SYS(fail, "ip link add link veth7 name veth7.66 type vlan id 66");
> +	SYS(fail, "ip link set veth7.66 netns %s", NS_VLAN_B);
> +
> +	parent_idx =3D if_nametoindex("veth7");
> +	if (!ASSERT_NEQ(parent_idx, 0, "if_nametoindex(veth7)"))
> +		goto fail;
> +
> +	/*
> +	 * input: the moved device is still in veth7's VLAN group, but it
> +	 * lives in another netns, so the lookup must fail closed
> +	 */
> +	skb.ifindex =3D parent_idx;
> +	memset(fib_params, 0, sizeof(*fib_params));
> +	fib_params->family =3D AF_INET;
> +	fib_params->l4_protocol =3D IPPROTO_TCP;
> +	fib_params->ifindex =3D parent_idx;
> +	fib_params->h_vlan_proto =3D htons(ETH_P_8021Q);
> +	fib_params->h_vlan_TCI =3D htons(66);
> +	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
> +		       1, "inet_pton(dst)"))
> +		goto fail;
> +

The IPs are hardcoded here (and in the rest of the code below). AFAICT the
logic is that the defines are to make it more obvious as to what the test
is about. Is there a logic of this kind behind the naming convention?

> +	skel->bss->fib_lookup_ret =3D -1;
> +	skel->bss->lookup_flags =3D BPF_FIB_LOOKUP_VLAN_INPUT |
> +				  BPF_FIB_LOOKUP_SKIP_NEIGH;
> +	err =3D bpf_prog_test_run_opts(prog_fd, &run_opts);
> +	if (!ASSERT_OK(err, "test_run(input)"))
> +		goto fail;
> +	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_NOT_FWDED,
> +		  "input across netns fails closed");
> +	ASSERT_EQ(fib_params->ifindex, parent_idx, "ifindex untouched");
> +	ASSERT_EQ(fib_params->h_vlan_TCI, htons(66), "tag untouched");
> +
> +	close_netns(nstoken);
> +	nstoken =3D open_netns(NS_VLAN_B);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns(b)"))
> +		goto fail;
> +
> +	/*
> +	 * egress: the fib result is the VLAN device here, but its parent
> +	 * is in the other netns, so the swap must not happen
> +	 */
> +	SYS(fail, "ip link set dev veth7.66 up");
> +	SYS(fail, "ip addr add 10.66.0.1/24 dev veth7.66");
> +	err =3D write_sysctl("/proc/sys/net/ipv4/conf/veth7.66/forwarding", "1"=
);
> +	if (!ASSERT_OK(err, "write_sysctl(forwarding)"))
> +		goto fail;
> +
> +	vlan_idx =3D if_nametoindex("veth7.66");
> +	if (!ASSERT_NEQ(vlan_idx, 0, "if_nametoindex(veth7.66)"))
> +		goto fail;
> +
> +	memset(fib_params, 0, sizeof(*fib_params));
> +	fib_params->family =3D AF_INET;
> +	fib_params->l4_protocol =3D IPPROTO_TCP;
> +	fib_params->ifindex =3D vlan_idx;
> +	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
> +		       1, "inet_pton(dst)") ||
> +	    !ASSERT_EQ(inet_pton(AF_INET, "10.66.0.1", &fib_params->ipv4_src),
> +		       1, "inet_pton(src)"))
> +		goto fail;

<SNIP>

