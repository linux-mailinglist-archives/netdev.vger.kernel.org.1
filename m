Return-Path: <netdev+bounces-255558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCFuHpCgfml4bgIAu9opvQ
	(envelope-from <netdev+bounces-255558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:38:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF2C4834
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A4D301725B
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1719DFAB;
	Sun,  1 Feb 2026 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8rNMoEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185A3D3B3;
	Sun,  1 Feb 2026 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769906316; cv=none; b=WoFOxKlBNOHStz9OtTGCKR2dbRjqywO9tLP0h4Pe6Mi6liZx/x8FjlFYQNKsjZj7GpNAUjmO0iN67l9pek1qI4RcoczBokoOnNkMD9QOsY3t+GFCvVfCDcDOyk3wqmzKOQRIxcwv92Am3VHB8Onk3DVvcsxdo31sLy9V9vEsaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769906316; c=relaxed/simple;
	bh=O8FUssz1TBM/Vz8EXid9I/fJq0G1tpON2mr0Syo5JLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrYu7fhmEC9daLP2lFWXqvHns3XRtLREn5AiBeh6848K/FPMqXQBBPwPfYEjRWcfcgGzk9d113A+3izo1+8wvW8vYDWhmyJ9fv2PVyGg813dK6QZIeyTUh8H9yoMMAr9hR7NFcqEVzrco6PPf2pgOKULlEeCp3RgtQArvgjSExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8rNMoEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55865C4CEF1;
	Sun,  1 Feb 2026 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769906316;
	bh=O8FUssz1TBM/Vz8EXid9I/fJq0G1tpON2mr0Syo5JLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8rNMoEBPE5grsPcla115jNNfF9TBr4ZEITep8eTzJjsF0nZST1GuGx9sqGirnHWu
	 kG7me3oV5UHE2edkTOekXpOOjw1YODfs026dF2DdUTQL58/kdIHv3m2ywfYTMxuZEC
	 Nioi29aiATv4PDRDHJPg+MYBY948Htwd/b4Ou1DK+zVDGtVQq2iO7y+KOZA2sZ29yD
	 2/+lRFc3vGQGh8VRSmLdtUhJsJpeSJaVLbq5l7qs5tAjQQc8+bl9o8cf/qk1l9R9bO
	 BUqDk3NSyPuPee37yqG0z/fAOI+SVIyO/GNtbH5zxWEnGV9erjqipqRETGEtX5IpAy
	 YPipbdq+1vwZw==
Date: Sat, 31 Jan 2026 16:38:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
Message-ID: <20260131163834.2c3d160d@kernel.org>
In-Reply-To: <20260129222830.439687-16-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netns.name:url]
X-Rspamd-Queue-Id: D0FF2C4834
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
> +class NetDrvContEnv(NetDrvEpEnv):
> +    """
> +    Class for an environment with a netkit pair setup for forwarding traffic
> +    between the physical interface and a network namespace.

A little diagram would be pretty awesome to have here, and perhaps copy
it to the README file too?

> +    """
> +
> +    def __init__(self, src_path, rxqueues=1, **kwargs):
> +        super().__init__(src_path, **kwargs)
> +
> +        self.require_ipver("6")
> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
> +        if not local_prefix:
> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
> +
> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> +        self.ipv6_prefix = f"{local_prefix}::"
> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
> +
> +        self.netns = None
> +        self._nk_host_ifname = None
> +        self._nk_guest_ifname = None
> +        self._tc_attached = False
> +        self._bpf_prog_pref = None
> +        self._bpf_prog_id = None
> +        self._init_ns_attached = False

I'm not a Python expert but the pre-init of variables that are set
later on in __init__() (on all possible paths) seems like a waste of LoC

> +
> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")

Would we be able to do this with YNL?
no big deal but always nice to avoid the dependency on very latest CLI

> +        all_links = ip("-d link show", json=True)
> +        netkit_links = [link for link in all_links
> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
> +                        and 'UP' not in link.get('flags', [])]

And of course if you use YNL you can actually ask Netlink to
echo back / return to you what interface it ended up creating.
No need for the scanning..

> +        if len(netkit_links) != 2:
> +            raise KsftSkipEx("Failed to create netkit pair")
> +
> +        netkit_links.sort(key=lambda x: x['ifindex'])
> +        self._nk_host_ifname = netkit_links[1]['ifname']
> +        self._nk_guest_ifname = netkit_links[0]['ifname']
> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
> +
> +        self._setup_ns()
> +        self._attach_bpf()

> +    def _setup_ns(self):
> +        self.netns = NetNS()
> +        cmd("ip netns attach init 1")
> +        self._init_ns_attached = True
> +        ip("netns set init 0", ns=self.netns)

Hm, refactor class NetNSEnter or just use its enter method?

> +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
> +        ip(f"link set dev {self._nk_host_ifname} up")
> +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
> +
> +        ip("link set lo up", ns=self.netns)
> +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
> +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
> +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
> +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
> +
> +    def _attach_bpf(self):
> +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
> +        if not bpf_obj.exists():
> +            raise KsftSkipEx("BPF prog not found")
> +
> +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
> +        self._tc_attached = True
> +
> +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout

Don't we need to also add a qdisc if there isn't one already?

> +        match = re.search(r'pref (\d+).*nk_forward\.bpf.*id (\d+)', tc_info)

I haven't checked but TC doesn't support enough JSON and YNL doesn't
support enough TC to avoid re hacks? :( :(


As I mentioned to David in person, Wei Wang also needs to use this
class for PSP tests so would be awesome to detach these from the large
series. I promise to prioritize the "detached" bits of these series in
case you're worried about the MW.

