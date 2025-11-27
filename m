Return-Path: <netdev+bounces-242164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E827C8CE49
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C04F3AA2A7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F564242D62;
	Thu, 27 Nov 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="im9e9ddc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80943258EFB
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223711; cv=none; b=B815VO4EQe4aV/BHZ+e2zMQ4rgZWuKdNMVzZXIONeRr2mfgH0DLb7x44hgcRxblJzS4XWk26OiiFsC/ihRPB2GohR0BzN4Iv0ohvyw7+YnWOvaTbuEkoVC+4AVZvswwFBqhMQ33++MunOcERnnAkXjPWK3SREgOxG+hEzsqu/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223711; c=relaxed/simple;
	bh=08Hd5rD81Quc+8M/4WmMVmqKdYZHuyxo3wb8LH7jeKY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVCOvTgXTuigqDQFBYW8G3lXQ/lYyKupgMb8yx86mnQH+fKukiwKcnCPKuUPmQphUsB4JZ38nMxzI5VvEUe+TFPXg27qC5eJyreRM/hb09ieLlmXNdmAy/P7YRADYzKOFELPA7QZP49SdzafvVsCjXDhtu6AEVRHJm3XFbSVISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=im9e9ddc; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fmkahaajpzg5jdicaadshb2fvy.protonmail; t=1764223698; x=1764482898;
	bh=08Hd5rD81Quc+8M/4WmMVmqKdYZHuyxo3wb8LH7jeKY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=im9e9ddc9y+uSapR/rLRrzKkJObxkvH3vtEVY6U2CkNSMhYUCIB6PNWFVXNZYLt/4
	 6loQBnF5X+cGB0MwaQl29Sw4sJWNrJR/jhOMQ1kz4x/hcdGzJYf68Lqc20nCxm7vf1
	 Ps3/9TZ+tmIf4qLlgg3Gf58z9DZVEyW+M8x9G6xyznluhej9Ih1jN+LRNQRqU2cVPK
	 HWNfYXYKkTSnL7acuF9sxSk1fr2nQMX6tfxxhnkqfPdppOMy6sN4rl8BOmzPHWgl0F
	 NYWg9NU30WkhvnMtJsC50grXTdalQarZNsJup0ky7sN7D/7UewXY55X03jhEYiGx+u
	 e0Le11O4BGE2g==
Date: Thu, 27 Nov 2025 06:08:13 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: =?utf-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, will@willsroot.io, savy@syst3mfailure.io
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <ASx87MmTb79KImWwsBhstFGoue2UNiX4l0Y0NXCSob-VNrOsz05jh8lG76DbQ7FWjGABCdc45LY6vQ3VI7UIv4KzI5LI2mB65eje2PwlHrE=@proton.me>
In-Reply-To: <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com>
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain> <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com> <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me> <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com>
Feedback-ID: 167072316:user:proton
X-Pm-Message-ID: a77bbff09d9bc9bec0c745682ac547eabea15c9b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mr Salim,

I do not understand what your saying. You provide a bash script, and I can =
test

- Ji-Soo

=EC=97=90 2025=EB=85=84 11=EC=9B=94 22=EC=9D=BC =ED=86=A0=EC=9A=94=EC=9D=
=BC 17:24 Jamal Hadi Salim <jhs@mojatatu.com> =EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1=ED=95=A8:

>=20
>=20
> Hi =EC=A0=95=EC=A7=80=EC=88=98,
>=20
> On Sat, Nov 22, 2025 at 1:56=E2=80=AFAM =EC=A0=95=EC=A7=80=EC=88=98 jschu=
ng2@proton.me wrote:
>=20
> > #!/bin/bash
> >=20
> > set -euo pipefail
> >=20
> > DEV=3D"wlo0"
> > QUEUE=3D"1"
> > RTP_DST_PORT=3D"5004"
> > DUP_PCT=3D"25%"
> > CORR_PCT=3D"60%"
> > DELAY=3D"1ms"
> > VERIFY_SECONDS=3D15
> >=20
> > usage(){ echo "Usage: sudo $0 [-d DEV] [-q QUEUE] [-P UDP_PORT]"; exit =
1; }
> > while [[ $# -gt 0 ]]; do
> > case "$1" in
> > -d) DEV=3D"$2"; shift 2;;
> > -q) QUEUE=3D"$2"; shift 2;;
> > -P) RTP_DST_PORT=3D"$2"; shift 2;;
> > *) usage;;
> > endac
> > done || true
> >=20
> > [[ -d /sys/class/net/$DEV ]] || { echo "No such dev $DEV"; exit 1; }
> >=20
> > if ! tc qdisc show dev "$DEV" | grep -q ' qdisc mq '; then
> > echo "Setting root qdisc to mq.."
> > tc qdisc replace dev "$DEV" root handle 1: mq
> > fi
> >=20
> > echo "Adding ntuple to steer UDP dport $RTP_DST_PORT -> tx-queue $QUEUE=
..."
> > ethtool -N "$DEV" flow-type udp4 dst-port $RTP_DST_PORT action $QUEUE |=
| {
> > echo "some flows will still land on :$QUEUE"
> > }
> >=20
> > echo "Attaching netem duplicate=3D$DUP_PCT corr=3D$CORR_PCT delay=3D$DE=
LAY on parent :$QUEUE.."
> > tc qdisc replace dev "$DEV" parent :$QUEUE handle ${QUEUE}00: \
> > netem duplicate "$DUP_PCT" "$CORR_PCT" delay "$DELAY"
> >=20
> > tc qdisc show dev "$DEV"
> >=20
> > echo
> > echo "Start an RTP/WebRTC/SFU downlink to a test client on UDP port $RT=
P_DST_PORT."
> > echo "Capturing for $VERIFY_SECONDS s to observe duplicates by RTP seqn=
o.."
> > timeout "$VERIFY_SECONDS" tcpdump -ni "$DEV" "udp and dst port $RTP_DST=
_PORT" -vv -c 0 2>/dev/null | head -n 3 || true
> >=20
> > if command -v tshark >/dev/null 2>&1; then
> > echo "tshark live RTP view :"
> > timeout "$VERIFY_SECONDS" tshark -i "$DEV" -f "udp dst port $RTP_DST_PO=
RT" -q -z rtp,streams || true
> > fi
> >=20
> > echo
> > echo "Netem stats, see duplicated counters under handle ${QUEUE}00:):"
> > tc -s qdisc show dev "$DEV" | sed -n '1,200p'
>=20
>=20
> Thanks for the config.
>=20
> If you can talk about it: I was more interested in what your end goal is.
> From the dev name it seems $DEV is a wireless device? Are you
> replicating these RTP packets across different ssids mapped to
> different hw queues? Are you forwarding these packets? The ethtool
> config indicates the RX direction but the netem replication is on the
> tx.
> And in the short term if a tc action could achieve what you are trying
> to achieve - would that work for you?
>=20
> cheers,
> jamal

