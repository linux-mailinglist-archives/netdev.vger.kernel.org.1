Return-Path: <netdev+bounces-153813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA09F9C49
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79061888724
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF11A8406;
	Fri, 20 Dec 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="r5q7CeQh"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA1218E97
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731207; cv=none; b=AwBmY2XZiMl+q3WWb4+U37HrZNN1CEIUwB1+CBvGz+qmJk9Z7CXW+Kr4Lk1CIGMKlRZJmFKfjSAgKK9U7s2F8GM37Kf+7T0FcUg4pPI1dkm/PvnzuaURJtJBNGVPUx3ecnfJypiIDdHX6ryo6/uNVT5rjwo07ltlZrugMvZAuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731207; c=relaxed/simple;
	bh=bim4A8tY9OX7cGW/mqJQBePRms00beagziw1lgasJpc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dZfoGWcnijyvsf143GPsjC1wPIghqhFePioFaQ2HA8tdh9Kv9fZHxW5XKAGFwUlunZrmaKI5x5RilJ8AL3Sp+OIulJqeT2GK/LcSGCA8KXOnQC74RP+sZK+pU9ZiEn4MToq8SzZjuHII1UKe/1xCM0zDuc774uapMuAsYDR9fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=r5q7CeQh; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 4BKLka9t020135
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Dec 2024 21:46:39 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 4BKLka9t020135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1734731200; bh=bim4A8tY9OX7cGW/mqJQBePRms00beagziw1lgasJpc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=r5q7CeQhGldLok8kJ0UBXP11www9YWmaOMwsWlMb6eQ1sxzY+mFadTXWleOiD5bXA
	 M7LaiJ3ZQg60sfnckYSYxlbuG8o7uh6DY3EAY8O2ryKofWrF7DOhr21uCvWkRaZlFg
	 QkLQbcREbbiTACm6olq1kDGSogWmW7jVbI5Nm+/H6QALpn/zyyovLdEYmVJtWP9qRd
	 XxhfZXADFQhXdraL5oIsThoaXiDd9Ogg1DmX7OXSt4sJ7nxE2KoBJji3gekQqyCpb9
	 h80AO6HGg0dtpOBpQEmP97ra9yVGxrXRSnAxH6Bw+LPVaE9xaugbjnYp48BEoFRty9
	 4npfQQC46pvHg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: net: dsa: mv88e6xxx architecture
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20241220121010.kkvmb2z2dooef5it@skbuf>
Date: Sat, 21 Dec 2024 08:46:26 +1100
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BAB5C0F-9E22-401B-8B04-1592E6C67971@padl.com>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

Hi Vladimir,

> I think we need an AVB primer. What identifies an AVB stream? Should =
the
> kernel have a database of them? What actions need to be taken for AVB
> streams different than for best effort traffic? Is it about scheduling
> priority, or about resource reservations, or? Does the custom behavior
> pertain only to AVB streams or is it a more widely useful mechanism?

AVB is an umbrella term which encompasses 802.1AS (gPTP), 802.1Qav =
(CBS), 802.1Qat (SRP), and various application layer protocols. This =
patch series is concerned with CBS and, tangentially, SRP: the existing =
mv88e6xxx PTP support sufficies for 802.1AS, and the application layer =
protocols are of no concern to the kernel. Further, the existing TC =
abstractions for CBS also suffice, and the patch series simply =
implements those.

Your question: what is an AVB stream, and what (if any) state needs to =
be maintained in the kernel?

Stream reservations, between =E2=80=9Ctalkers=E2=80=9D (sources) and =
=E2=80=9Clisteners=E2=80=9D (sinks) are coordinated by the Multiple =
Stream Reservation Protocol (MSRP). (Confusingly, _SRP_ itself is an =
umbrella term encompassing MVRP, MMRP and MSRP. The existing MVRP =
support in the kernel only implements part of the MRP state machine.)

MSRP coordinates talker advertisements (consisting of a 64-bit stream =
ID, a [typically multicast] DA, VID, bandwidth requirement, and PCP) =
with listener advertisements. It also coordinates =E2=80=9Cdomain=E2=80=9D=
 advertisements which establish a mapping between AVB or SRP =
=E2=80=9Cclasses=E2=80=9D, and a (PCP, VID) tuple.

At a high level, the kernel does not need to know anything about SRP: it =
can, and IMO should (like the PTP state machine) be implemented =
completely in user space. Once SRP has established there is sufficient =
bandwidth and latency for a steam to flow, it adds the stream DA to the =
FDB or MDB, and configures the CBS policy appropriately on the egress =
port.

The catch is what to do with frames that share a priority with an AVB =
class but are not negotiated by SRP. These frames could crowd out frames =
from AVB streams. Marvell=E2=80=99s solution is a flag in the ATU which =
indicates that the DA was added by SRP. This is the one case where a new =
kernel interface (specifically, a flag passed down to {fdb,mdb}_add()), =
could be useful. In lieu of that, the patch currently uses a new Kconfig =
option to indicate that _all_ static FDB/MDB entries should have that =
flag set, noting that CBS is still usable without this option.

> What is the lifetime of an AVB packet in the Marvell DSA switches (in
> enhanced AVB mode)? Where do they go from these global queues? Still =
to
> the individual port TX queues, I assume? I find it a bit difficult to
> understand the concept of global queues.

A poor explanation on my part. Briefly: FPri is the switch=E2=80=99s =
internal frame priority derived from PCP or DSCP, and QPri is queue =
number.

* PCP/DSCP to FPri mappings are per port
* TX _queues_ are per-port
* The _mapping_ between FPri and QPri is per-switch (at least, pre-6390 =
family).
* Where the admission control described above is enabled, each SRP class =
must be assigned a designated FPri and QPri, and this configuration is =
per-switch

> I don't understand this. A mapping between which port's traffic =
classes
> and the global AVB classes? You're saying that mqprio TCs 2 and 1 of =
all
> ports are backed by the same queues?

The same queue _numbers_ but not the same queues. Configuring per-port =
FPri to QPri mappings is possible on the 6390 family, but not with SRP =
admission control.=20

The current patch reference counts the MQPRIO policy so that it can be =
applied or removed from additional ports, but only replaced when one =
referent remains.

Cheers,
Luke

