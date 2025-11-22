Return-Path: <netdev+bounces-240948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A948C7C8E5
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 07:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22A584E111F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B724677B;
	Sat, 22 Nov 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OLoI97hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11C231A41
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794592; cv=none; b=IOsfUxplNdgL9iwUfiR5MnordINUwlZQJt+PTJwNto333DaKjUxUjRvRXhBbdcZc+RLNi67+pqrrHSN1Cx3OeXawQY0541wmCcSZwz+jY4MGZEpIY1mcldg6un6zVFgw65LFsui+Qi6Bg8+0o8xPwEPBHlRHp2s8KnS3UeTfxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794592; c=relaxed/simple;
	bh=Oq7shMpkSPnF2Cj5I9mGy3eJt7w0SuGXAWNrUErUpSM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZYm6etDgnCFi5bcf71ArNKESoSTwgHRisxse5VMwU0sbyJ4DTZpBRCkTkV6yp4H19+2gPQNSnCl1ndDl48KdO1ClE3W2O0FQLmGwBcPV4PSeiIrKP0Or42qh0yFZRFhk80cziOo+6hNs4ZpDSI1MpLp9p2h4a9/ElB2WhH/KF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OLoI97hw; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1763794581; x=1764053781;
	bh=jd6WkwRrQXFpaZVBaET1ebWQT4S0SQAhfe0KGX7Snco=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OLoI97hwGd+9ZInnm1MUsMlPFkUIr2nZXNiOTnXAnDHISxbsEWcCM0QtCcl60syNR
	 seYRh7bD35r4FWEXn/7aM2+y4UZUOZrkTmGz4vLKENZhjMJYlIZi61HyFq73qXTu67
	 TQZiiFpSxhqCvUsSHrZ8ueUh0HY8JWXMfjx+nzZXjnWskRCHMYoIE1RYIslPlpWLny
	 mFT364WsZUK0hPB6KRE2sIHDE5mTaNoBsbRa6q/A+RHhQzUsKbeDsnDyPms/IbpkUi
	 3RobABTrdcmsWZrdPyLG927eQdumZ1N5zJr3S4dpQDMQ5q1Zy75pq24rLud7JgBZ7v
	 f4QChTMmBbPyA==
Date: Sat, 22 Nov 2025 06:56:18 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: =?utf-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, will@willsroot.io, savy@syst3mfailure.io
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me>
In-Reply-To: <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain> <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
Feedback-ID: 167072316:user:proton
X-Pm-Message-ID: b5e21a07b90d8317f58f311159681504a4c7c54d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


#!/bin/bash

set -euo pipefail

DEV=3D"wlo0"
QUEUE=3D"1"
RTP_DST_PORT=3D"5004"
DUP_PCT=3D"25%"
CORR_PCT=3D"60%"
DELAY=3D"1ms"
VERIFY_SECONDS=3D15

usage(){ echo "Usage: sudo $0 [-d DEV] [-q QUEUE] [-P UDP_PORT]"; exit 1; }
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d) DEV=3D"$2"; shift 2;;
    -q) QUEUE=3D"$2"; shift 2;;
    -P) RTP_DST_PORT=3D"$2"; shift 2;;
    *) usage;;
  endac
done || true

[[ -d /sys/class/net/$DEV ]] || { echo "No such dev $DEV"; exit 1; }


if ! tc qdisc show dev "$DEV" | grep -q ' qdisc mq '; then
  echo "Setting root qdisc to mq.."
  tc qdisc replace dev "$DEV" root handle 1: mq
fi


echo "Adding ntuple to steer UDP dport $RTP_DST_PORT -> tx-queue $QUEUE..."
ethtool -N "$DEV" flow-type udp4 dst-port $RTP_DST_PORT action $QUEUE || {
  echo "some flows will still land on :$QUEUE"
}


echo "Attaching netem duplicate=3D$DUP_PCT corr=3D$CORR_PCT delay=3D$DELAY =
on parent :$QUEUE.."
tc qdisc replace dev "$DEV" parent :$QUEUE handle ${QUEUE}00: \
  netem duplicate "$DUP_PCT" "$CORR_PCT" delay "$DELAY"

tc qdisc show dev "$DEV"

echo
echo "Start an RTP/WebRTC/SFU downlink to a test client on UDP port $RTP_DS=
T_PORT."
echo "Capturing for $VERIFY_SECONDS s to observe duplicates by RTP seqno.."
timeout "$VERIFY_SECONDS" tcpdump -ni "$DEV" "udp and dst port $RTP_DST_POR=
T" -vv -c 0 2>/dev/null | head -n 3 || true


if command -v tshark >/dev/null 2>&1; then
  echo "tshark live RTP view :"
  timeout "$VERIFY_SECONDS" tshark -i "$DEV" -f "udp dst port $RTP_DST_PORT=
" -q -z rtp,streams || true
fi

echo
echo "Netem stats, see duplicated counters under handle ${QUEUE}00:):"
tc -s qdisc show dev "$DEV" | sed -n '1,200p'




Sent with Proton Mail secure email.

On Friday, November 21st, 2025 at 12:52, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

> On Thu, Nov 20, 2025 at 11:29=E2=80=AFPM Cong Wang xiyou.wangcong@gmail.c=
om wrote:
>=20
> > Hi Will, Jamal and Jakub,
> >=20
> > I already warned you many times before you applied it. Now we have user=
s
> > complaining, please let me know if you still respect users.
> >=20
> > Also, Jamal, if I remember correctly, you said you will work on a long
> > term solution, now after 4 months, please let us know what your plan is=
.
> >=20
> > Regards,
> > Cong
> >=20
> > On Mon, Nov 10, 2025 at 12:38:07PM -0800, Stephen Hemminger wrote:
> >=20
> > > Regression caused by:
> > >=20
> > > commit ec8e0e3d7adef940cdf9475e2352c0680189d14e
> > > Author: William Liu will@willsroot.io
> > > Date: Tue Jul 8 16:43:26 2025 +0000
> > >=20
> > > net/sched: Restrict conditions for adding duplicating netems to qdisc=
 tree
> > >=20
> > > netem_enqueue's duplication prevention logic breaks when a netem
> > > resides in a qdisc tree with other netems - this can lead to a
> > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > Ensure that a duplicating netem cannot exist in a tree with other
> > > netems.
> > >=20
> > > Previous approaches suggested in discussions in chronological order:
> > >=20
> > > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > > too specific a use case to extend such a struct, though this would
> > > be a resilient fix and address other previous and potential future
> > > DOS bugs like the one described in loopy fun [2].
> > >=20
> > > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > > per cpu variable. However, netem_dequeue can call enqueue on its
> > > child, and the depth restriction could be bypassed if the child is a
> > > netem.
> > >=20
> > > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > > to handle the netem_dequeue case and track a packet's involvement
> > > in duplication. This is an overly complex approach, and Jamal
> > > notes that the skb cb can be overwritten to circumvent this
> > > safeguard.
> > >=20
> > > 4) Prevent the addition of a netem to a qdisc tree if its ancestral
> > > path contains a netem. However, filters and actions can cause a
> > > packet to change paths when re-enqueued to the root from netem
> > > duplication, leading us to the current solution: prevent a
> > > duplicating netem from inhabiting the same tree as other netems.
> > >=20
> > > [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc=
1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=
=3D@willsroot.io/
> > > [2] https://lwn.net/Articles/719297/
> > >=20
> > > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > > Reported-by: William Liu will@willsroot.io
> > > Reported-by: Savino Dicanosa savy@syst3mfailure.io
> > > Signed-off-by: William Liu will@willsroot.io
> > > Signed-off-by: Savino Dicanosa savy@syst3mfailure.io
> > > Acked-by: Jamal Hadi Salim jhs@mojatatu.com
> > > Link: https://patch.msgid.link/20250708164141.875402-1-will@willsroot=
.io
> > > Signed-off-by: Jakub Kicinski kuba@kernel.org
> > >=20
> > > Begin forwarded message:
> > >=20
> > > Date: Mon, 10 Nov 2025 19:13:57 +0000
> > > From: bugzilla-daemon@kernel.org
> > > To: stephen@networkplumber.org
> > > Subject: [Bug 220774] New: netem is broken in 6.18
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> > >=20
> > > Bug ID: 220774
> > > Summary: netem is broken in 6.18
> > > Product: Networking
> > > Version: 2.5
> > > Hardware: All
> > > OS: Linux
> > > Status: NEW
> > > Severity: high
> > > Priority: P3
> > > Component: Other
> > > Assignee: stephen@networkplumber.org
> > > Reporter: jschung2@proton.me
> > > Regression: No
> > >=20
> > > [jschung@localhost ~]$ cat test.sh
> > > #!/bin/bash
> > >=20
> > > DEV=3D"eth0"
> > > NUM_QUEUES=3D32
> > > DUPLICATE_PERCENT=3D"5%"
> > >=20
> > > tc qdisc del dev $DEV root > /dev/null 2>&1
> > > tc qdisc add dev $DEV root handle 1: mq
> > >=20
> > > for i in $(seq 1 $NUM_QUEUES); do
> > > HANDLE_ID=3D$((i * 10))
> > > PARENT_ID=3D"1:$i"
> > > tc qdisc add dev $DEV parent $PARENT_ID handle ${HANDLE_ID}: netem
> > > duplicate $DUPLICATE_PERCENT
> > > done
>=20
>=20
> jschung2@proton.me: Can you please provide more details about what you
> are trying to do so we can see if a different approach can be
> prescribed?
>=20
> cheers,
> jamal
>=20
> > > [jschung@localhost ~]$ sudo ./test.sh
> > > [ 2976.073299] netem: change failed
> > > Error: netem: cannot mix duplicating netems with other netems in tree=
.
> > >=20
> > > [jschung@localhost ~]$ uname -r
> > > 6.18.0-rc4
> > >=20
> > > --
> > > You may reply to this email to add a comment.
> > >=20
> > > You are receiving this mail because:
> > > You are the assignee for the bug.

