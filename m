Return-Path: <netdev+bounces-210297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D425B12B52
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DCB3B9CB6
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA4224AFA;
	Sat, 26 Jul 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="tsHv8HTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252991A08BC
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545887; cv=none; b=BZMFVVExnkR9SzS+MyfN+ORS11NnLw7/VhAYmhzOcUTs4SfcoU55PQUYaaO59doUAUmjBwWdgUQPetUfcDgdarEbEOX+DIW8Z8aSxRIC/afmhS+eT21pHrZ9AmV25XxFK6oJKEwffnfBf9s/0/s2KyqLsEjTQf1fEV3XnFlgJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545887; c=relaxed/simple;
	bh=tGmS0MbE6YqP5lWfxlEVqwRSRlDuXVaEsmVQmBTmCMs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaD3jYGwo8jOsVpQ8uGkuJPKXlyEuzHcJuuY/TKhNDnrnnm6zE1w0fJVh0md025hNtRhNZUbdxaRakh1sfHQVw2VyYZ1cBHCG+kTJMczcRTbXqV7wkVB98QljqLgXPkeOUgNBgCqclqpKNtGurmh5JAheYp6V1uAdr48uEEbCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=tsHv8HTc; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753545879; x=1753805079;
	bh=tGmS0MbE6YqP5lWfxlEVqwRSRlDuXVaEsmVQmBTmCMs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tsHv8HTcX8V6ORbZY+C1Jr/KjGsYxfYUjw/IYx4bR11d6qtlP+PbQ+HRuvUmj/A6Q
	 Gjaze03mZMPiKYRvdKPGjtJOMGbUrbGmo6/K+1JLd7vGt5kXNatCavNrD/yyzj+r/U
	 g5GOK6cRREYrVQkAjaeQ0FOPbRSWS0X5A+AgoHVI+b5Mm2vbC6l7QIa7gHOXHObM3L
	 r/Pff4NZ//cV8TFEp5ohYQhtRe/bGbrrBmqxjFZAuszygQyZ9HtztgvK8NNVPeMaT/
	 gLmuRbgc/cpeQQKRMZkl32mq4MsODaron9uCUmt3g3cKYM64+LI4/SVGd8O3tO2eXu
	 3xH2p52XnnbZg==
Date: Sat, 26 Jul 2025 16:04:33 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net v2 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <B8J1l8WROec_5SO22mW3x14RB4EaaMDgyXKYD-U_3H2vyJO0yUbD0ufDYc8vPshaBM0lLi1uTmA0TKVfXI-aANfL7gLUVx_GK_5UpPPStFc=@willsroot.io>
In-Reply-To: <aIQKJlbq61svuSoy@pop-os.localdomain>
References: <20250724165507.20789-1-will@willsroot.io> <20250724165530.20862-1-will@willsroot.io> <aIQKJlbq61svuSoy@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: a281de7d06d0348bb9d0936799474f4fa27eaf16
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 25th, 2025 at 10:50 PM, Cong Wang <xiyou.wangcong@gmail.com=
> wrote:

>=20
>=20
> On Thu, Jul 24, 2025 at 04:55:53PM +0000, William Liu wrote:
>=20
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.j=
son b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > index c6db7fa94f55..867654a31a95 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > @@ -185,6 +185,207 @@
> > "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
> > ]
> > },
> > + {
> > + "id": "34c0",
> > + "name": "Test TBF with HHF Backlog Accounting in gso_skb case",
> > + "category": [
> > + "qdisc",
> > + "tbf",
> > + "hhf"
> > + ],
> > + "plugins": {
> > + "requires": [
> > + "nsPlugin",
> > + "scapyPlugin"
>=20
>=20
> scapyPlugin is not required unless you generate traffic with scapy
> instead of ping.
>=20

Ok I shall update this.

> > + ]
> > + },
> > + "setup": [
> > + "$IP link set dev $DUMMY up || true",
> > + "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
> > + "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b lat=
ency 100ms",
> > + "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 hhf limit 1000",
> > + [
> > + "ping -I $DUMMY -f -c8 -s32 -W0.001 10.10.11.11",
> > + 1
>=20
>=20
> What is this magic number here? :)
>=20
>=20

That's from the original repro. I can simplify it a bit.

> Thanks.

