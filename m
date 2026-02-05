Return-Path: <netdev+bounces-256923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLtQGAAChGk+wwMAu9opvQ
	(envelope-from <netdev+bounces-256923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:35:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FAEDFFC
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81A6302D134
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806822BDC2F;
	Thu,  5 Feb 2026 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq7iynkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305241F131A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258868; cv=none; b=F3D+eOQeg3CQkw+5y185SW2JNh7AIy29d4zpOzrEijv7BRFCEw5avzewP7kDIKdFa9A9RdiHhA35whDfISb3xc4N7MtuGxVYXyEqXLO7SLz/tOwMZl8NllebmIozyCt9XNFy/k0LhKQUfnyI2pnQj9Ur2zJXd2flABkLTL6JqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258868; c=relaxed/simple;
	bh=UFAU54HdP2dYY9mu9+YXWTb1xE3S9Mki0hlpCFtBBmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld/pJDqihszMqTdBZ+g/EePG1mfzlVmAh4BgDyUsP1HdEdTjNO9WBA/XNXIh9IkdIdE0+5vqaT+Gr+F/iPB98K4TbjtbMG/obe9W0VjG4LaqND0FGqlPmlyr0J8teFUorxKQVpx4jQJ3qmqXCom6cu6firHFi9bOSHJ5ujlWftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq7iynkF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794f701a3e6so4386757b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770258867; x=1770863667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+42VXTEpQZ45JO+UQbhd4FcXvztHFo9rbvBGnqtcZk=;
        b=fq7iynkFOhj2v6FAuzJATilDxVEpisZH9hs6B38HQEEtroXDRxU1tW8mhbJcv9/A+P
         eVj0sgRhGWvKtXKkPXfb18Tv8Q11EhZ3NzGNo348wxHj43Rhh4Nlho7ns3AnIcGYGSUv
         lfauIEcfPkVpxa2QQVQu37dweuEGLK8ogb2vweDZm04ycg8+Q7ggJoUymQPTPWTMV425
         JtW7PMEYp4Ez7e7xvOWMfyCAM5AKDd9Kj8YZiOM7RihkEIVNfaiz8P7ihh+3T9lQrIry
         SwlI0ZIRXO573Sa+9Xj5Qfyw7uGs4WOL1ZKnl10mWIHdOgFCtH9joD1wkvcQUPkHrDMn
         2lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770258867; x=1770863667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+42VXTEpQZ45JO+UQbhd4FcXvztHFo9rbvBGnqtcZk=;
        b=p7+p1LamaDVEDzKobTuf+g3XWCFQ1q8pKgCWEliVjEDaUwbbNT+StneTVo1SsC0V0y
         N8GrABGl3KWcJkJJ5Gv/eX6qEFmMLgh1mKzv9SnrRu9Hhqi850A9ipNUlQvoV5opwVtu
         DMYQHQ25FGykt6Jn1bP3EB+WQQRLJbNudaejidPs4htLuhPUE5a7cLO9/xLhhN4JtDO3
         AvS66RTeoyrEu9wjmp35t4VdxQ+CQAyL1xIy94KWOArlX+wW159rsUsT54U394sQ2QR4
         uBcSFvyH9QnEyAJMvtJScD/tukaMAZT6HgourzX7OfLneA9z26ZnmwJRHk+pcHaT4az9
         maHg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1QTYNFRaOu4YYuvOdQpLSYGZ25SuPGaK/Mzucqx3nAf8hbi9ORtOMFLscLK0/SAVFHJBHT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFdXhvxFj4dsNwzkrgWPJ5rKTe1+yFC2W8N+5tE8frNBiE7xk
	LKj6hN9EdQonKTpKJtFoGX8JpNKJVnRcEzSuKIDiUbGMWiaY7XENxWRm
X-Gm-Gg: AZuq6aL+sR3gvJACj5ppT12XNZHxR7PMIi3jq3wGGiHTDAeqHeGCBFSe4uVjNRuZsh/
	lQKDdBuTV+WjKhIiND7Yriy5j1AK90JDZ+MS5nScuFSC4rs3RftIgMn9N7XjZ9e0rOaKAmnXeRL
	BcXfVVXC7X6dmT5CkdbPFjeMgZeoWuMEux/ZfHbCxyrqTa5OvEw/C9dN+kec7vQDVMdwj25kYa3
	OxZhz8Be8N5jQ5IzEF4rML5AfCqz1RJgjBizs+qn3YSincZZS3qXrTTY6E9U8JShUEYxtvrsCK7
	kUOGMOJwk/ujf2/5h+GMgTn7hZvqjRCHHEK3T+6TwguRusN0xOwfNQBJiSCLkQZyZOYl7+Bhg0C
	TezZasZAPA5a+LK+qQrVbboke6K2Hr4ikBm6bcO0IIPzQvX01X9DQjdgibWa4SLHDWr7sFZDWdc
	PyFlhkkPG1Rel58y2qER44DadUmFRw8dr8P90BSSwlamMx
X-Received: by 2002:a05:690c:4905:b0:794:c58e:2dab with SMTP id 00721157ae682-794fe6ac0b6mr47199667b3.20.1770258867093;
        Wed, 04 Feb 2026 18:34:27 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fed6d095sm36569707b3.0.2026.02.04.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:34:26 -0800 (PST)
Date: Wed, 4 Feb 2026 18:34:25 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
	pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
	john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
Message-ID: <aYQBsTfF4PrJcHNl@devvm11784.nha0.facebook.com>
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
 <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
 <aYP7uiuPWAbJEgLD@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYP7uiuPWAbJEgLD@devvm11784.nha0.facebook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,bytedance.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: AE8FAEDFFC
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 06:08:58PM -0800, Bobby Eshleman wrote:
> On Mon, Feb 02, 2026 at 07:53:34AM +0900, David Wei wrote:
> > On 2026-02-01 09:38, Jakub Kicinski wrote:
> > > On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
> > > > +class NetDrvContEnv(NetDrvEpEnv):
> > > > +    """
> > > > +    Class for an environment with a netkit pair setup for forwarding traffic
> > > > +    between the physical interface and a network namespace.
> > > 
> > > A little diagram would be pretty awesome to have here, and perhaps copy
> > > it to the README file too?
> > 
> > Sounds good, I'll add one. I forget how much you like ASCII diagrams.
> > 
> > > 
> > > > +    """
> > > > +
> > > > +    def __init__(self, src_path, rxqueues=1, **kwargs):
> > > > +        super().__init__(src_path, **kwargs)
> > > > +
> > > > +        self.require_ipver("6")
> > > > +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
> > > > +        if not local_prefix:
> > > > +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
> > > > +
> > > > +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> > > > +        self.ipv6_prefix = f"{local_prefix}::"
> > > > +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
> > > > +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
> > > > +
> > > > +        self.netns = None
> > > > +        self._nk_host_ifname = None
> > > > +        self._nk_guest_ifname = None
> > > > +        self._tc_attached = False
> > > > +        self._bpf_prog_pref = None
> > > > +        self._bpf_prog_id = None
> > > > +        self._init_ns_attached = False
> > > 
> > > I'm not a Python expert but the pre-init of variables that are set
> > > later on in __init__() (on all possible paths) seems like a waste of LoC
> > 
> > It's so that exceptions thrown -> __del__() don't complain about
> > undefined vars.
> > 
> > > 
> > > > +
> > > > +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
> > > 
> > > Would we be able to do this with YNL?
> > > no big deal but always nice to avoid the dependency on very latest CLI
> > 
> > Hmm, I tried looking into this already. My understanding is that this
> > can be done in C but not currently in YNL, not without adding a spec.
> > 
> > > 
> > > > +        all_links = ip("-d link show", json=True)
> > > > +        netkit_links = [link for link in all_links
> > > > +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
> > > > +                        and 'UP' not in link.get('flags', [])]
> > > 
> > > And of course if you use YNL you can actually ask Netlink to
> > > echo back / return to you what interface it ended up creating.
> > > No need for the scanning..
> > > 
> > > > +        if len(netkit_links) != 2:
> > > > +            raise KsftSkipEx("Failed to create netkit pair")
> > > > +
> > > > +        netkit_links.sort(key=lambda x: x['ifindex'])
> > > > +        self._nk_host_ifname = netkit_links[1]['ifname']
> > > > +        self._nk_guest_ifname = netkit_links[0]['ifname']
> > > > +        self.nk_host_ifindex = netkit_links[1]['ifindex']
> > > > +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
> > > > +
> > > > +        self._setup_ns()
> > > > +        self._attach_bpf()
> > > 
> > > > +    def _setup_ns(self):
> > > > +        self.netns = NetNS()
> > > > +        cmd("ip netns attach init 1")
> > > > +        self._init_ns_attached = True
> > > > +        ip("netns set init 0", ns=self.netns)
> > > 
> > > Hm, refactor class NetNSEnter or just use its enter method?
> > 
> > I did consider this but I didn't feel like it fit the very specific
> > purpose of NetNSEnter. I needed the init ns to have a valid nsid from
> > within the test netns, which I didn't think many other tests would need.
> > 
> > > 
> > > > +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
> > > > +        ip(f"link set dev {self._nk_host_ifname} up")
> > > > +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
> > > > +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
> > > > +
> > > > +        ip("link set lo up", ns=self.netns)
> > > > +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
> > > > +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
> > > > +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
> > > > +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
> > > > +
> > > > +    def _attach_bpf(self):
> > > > +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
> > > > +        if not bpf_obj.exists():
> > > > +            raise KsftSkipEx("BPF prog not found")
> > > > +
> > > > +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
> > > > +        self._tc_attached = True
> > > > +
> > > > +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
> > > 
> > > Don't we need to also add a qdisc if there isn't one already?
> > 
> > Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
> > know anything about qdisc, though.
> 
> The ingress qdisc is the attachment point. I think we need
> CONFIG_NET_SCH_INGRESS here too?

Sorry for the config stuff I'm replying about, I ran into needing these
too for this:

CONFIG_NET_CLS_BPF=y
CONFIG_BPF_SYSCALL=y 

