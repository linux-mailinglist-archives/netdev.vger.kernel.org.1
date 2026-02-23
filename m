Return-Path: <netdev+bounces-260035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JeeAktXnGkAEQQAu9opvQ
	(envelope-from <netdev+bounces-260035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:34:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14413176FA4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23A6A3007224
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF14223323;
	Mon, 23 Feb 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="meD5mbcz"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0B3A1D2
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853634; cv=none; b=Eju2UZMc+XytqZ1qvjL62xXzs9QGVYt9lC5ciMhFrTLCWf8OWqwR9KEMkUMVNtFFBhYO478IT5aLHDsJYTWbMJmZYMelMFdRGrxEytlE1kSoBR8JH9P9pemtsoS/ZAdV7RhQsTjoZIM/IIPJdF7IbTm4F6OS4mRjUxsZqRbJMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853634; c=relaxed/simple;
	bh=vwDHGZkNKcZgrDUmXykErc1y/rSOex9+J/bjnc8RUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekXgnlCmuKXmNEbn2eUd6v+9pK940U/gOrVdwcJgEl/JwYE8lXoR9O6a7of99lXi8oDwMMAuD0EzDFPRx1Me/p491vNu7G5W1WpBVdFKlxxTkximXtYbg75tVTp4SCfiQ4oeWcbHnkR4Z9gd2ZP2pfSHl/X4hp4v+Xg9oJt7jeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=meD5mbcz; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61NDWcbh055624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Feb 2026 22:32:40 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=MU4uqkPCUo1YSM7ORV3XeMLzQiNwxn5T39Jw0803mss=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=Date:From:To:Subject:Message-ID;
        s=rs20251215; t=1771853562; v=1;
        b=meD5mbczMUBA9iqvN7VIexPFQB9dAqCNgFbF9AbUC6KD43CJqE8IzSY/162US5k6
         d+qoClRbskcdvG6MrTes0dk0VDvIzlVxtbWG8lTdX3+gUU76GWmW28IVReC2e+v8
         T+PPrD1WWE3EMslcCi/mRoQcYqB+CIgvGDCnaDZqn7c1EHz5nT3Rg6RKlzJZpOUq
         /EFMNM97NxBzVdqwraFhm+BxLR35C0FWi4Z5jfLnMmyFBqGaxuCfyDogGKWp+H7K
         NY5u+/xbmLSGwidcXAhjL0VVJ6hRqydACi5ryCbSxMOe/GiEMGuJ5PV9IHvVt2cB
         pNpR4f+q2PsKoxLnSTz+yA==
Date: Mon, 23 Feb 2026 22:32:38 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
Message-ID: <aZxVELsXHvrpkicA@x1>
References: <20260220193039.7129-1-kohei@enjuk.jp>
 <87ikbnofug.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikbnofug.fsf@toke.dk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260035-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev,10cc7f13760b31bd2e61];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 14413176FA4
X-Rspamd-Action: no action

On 02/23 12:32, Toke Høiland-Jørgensen wrote:
> Kohei Enju <kohei@enjuk.jp> writes:
> 
> > get_upper_ifindexes() iterates over all upper devices and writes their
> > indices into an array without checking bounds.
> >
> > Also the callers assume that the max number of upper devices is
> > MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> > but that assumption is not correct and the number of upper devices could
> > be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> > stack-out-of-bounds write.
> >
> > Add a max parameter to get_upper_ifindexes() to avoid the issue.
> >
> > To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> > an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> > Then send a packet to the device to trigger the XDP redirect path.
> >
> > Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
> > Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > Changes:
> >   v2:
> >     - fix formatting, accounting that max-line-length is 100
> >   v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
> > ---
> >  kernel/bpf/devmap.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 2625601de76e..c8c49d86a403 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
> >  }
> >  
> >  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> > - * least MAX_NEST_DEV elements.
> > + * least 'max' elements.
> >   * Returns the number of ifindexes added.
> >   */
> > -static int get_upper_ifindexes(struct net_device *dev, int *indexes)

> > +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
> >  {
> >  	struct net_device *upper;
> >  	struct list_head *iter;
> >  	int n = 0;
> >  
> >  	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> > +		if (n >= max)
> > +			break;
> 
> Hmm, how about returning an error here, and aborting the redirect
> entirely? This silent truncation to an arbitrary number seems a bit
> surprising, and very hard to debug. With an error, there will at least
> be an error tracepoint to catch the failure.
> 
> -Toke

Hi, Toke. 

Thanks for the review.
Indeed I agree that silent truncation is surprising and hard to debug.
I'll send a v3 that returns -EOVERFLOW and aborts the redirect when
there are too many upper devices.

