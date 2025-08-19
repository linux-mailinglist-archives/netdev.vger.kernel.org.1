Return-Path: <netdev+bounces-214987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD2B2C780
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB41682A99
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58290279351;
	Tue, 19 Aug 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUwRw0ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbqVqTyt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410827B4EB
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615029; cv=none; b=qRMp1wHiSPBLVJYUxdsNFRN3C4nXjtOQeVhLMnmhHPz8xo9dCS7RC3pN20gHRxn318ghOvpKez03U9Pi0K8L8UlmKwHzGqU0u9VIHJhdbG+fUP2MbT2cxffhl7OwfBMgPaqGdIw8T4aSba41JLBBdF9WhvsqYYbR2b+kttT0Xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615029; c=relaxed/simple;
	bh=toXMenPmzF79QCt8zsMmYakv7wmuIYNt0yxcSa/CGfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWoP8V/9T4t/sqJD2pWFgeyfcUw6QmP+Jff4bvi1sjIhzWbRRXdGPFZbzox0pg7NlgCMYKFlN9sGDllnDRcPhYBzfv3feSJ0tNmfAvapggxFkYE4HSahroHLNxb9a5u0uG09e0D1hp8xUp3HowWW7wKfge6B3G29ogpO6b9Xm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUwRw0ht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbqVqTyt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755615025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptWEFgp23Tx0lKdgnYP80JrRtGCoawk5mA53LdcsBFI=;
	b=UUwRw0htleduy3eavpr9F+maRy6RvzIa/Z2WCu4VxB4qKl0s+sjepf13XYPcqHVq3TUbhW
	2E3QnG3mOnmwaOIf4LfOM/Z3wHm9P8sSA5GWW2bd8XAM+7UfILNcthbFRBFsRN2gXPOAf3
	Lp+3akpO56tjwnVqIJZ+v0l9hIi13RKOBmIab425f0nEsYhcaRWyGUXaHGkpEzCBZxR5Qu
	m/t/AfoN0dO9SU9QHPC71e5IfSF5Un9olH17x/yoeu7KlZJcvFRN5oxevBAxDpCnZid2QI
	j631LQrbhqaUy//tRjRYmGCac321ey4awSvMcUmDK5ZS9bf8J9cYEeL3D2vHBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755615025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptWEFgp23Tx0lKdgnYP80JrRtGCoawk5mA53LdcsBFI=;
	b=zbqVqTytKZdhDD8K+8+ooUPaO8p6XV9/yGnGKgsepXyVt9z4I0yDjJi8Meze1KDzgwV09N
	+aWpbyM9SnANu1CQ==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
In-Reply-To: <aKMbekefL4mJ23kW@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
Date: Tue, 19 Aug 2025 16:50:23 +0200
Message-ID: <87ms7vs6vk.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon Aug 18 2025, Miroslav Lichvar wrote:
> On Fri, Aug 15, 2025 at 08:50:23AM +0200, Kurt Kanzenbach wrote:
>> Retrieve Tx timestamp directly from interrupt handler.
>>=20
>> The current implementation uses schedule_work() which is executed by the
>> system work queue to retrieve Tx timestamps. This increases latency and =
can
>> lead to timeouts in case of heavy system load.
>>=20
>> Therefore, fetch the timestamp directly from the interrupt handler.
>>=20
>> The work queue code stays for the Intel 82576. Tested on Intel i210.
>
> I tested this patch on 6.17-rc1 with an Intel I350 card on a NTP
> server (chrony 4.4), measuring packet rates and TX timestamp accuracy
> with ntpperf. While the HW TX timestamping seems more reliable at some
> lower request rates, there seems to be about 40% drop in the overall
> performance of the server in how much requests it can handle (falling
> back to SW timestamps when HW timestamp is missed). Is this expected
> or something to be considered?=20

I have never ever used ntpperf before, so please bear with me. I've
setup two x86 machines with Debian Trixie, v6.17.0-rc1+ and Intel i210.

Installed ntpperf on one machine and chrony (v4.6) on the second. In the
chrony config there is 'hwtimestamp enp1s0'. I did run the first example
in ntpperf's README with the following results. 'rate' seems to be
higher with my patch applied. Anyway, your ntpperf output looks
completely different. What parameters are you using? I just want to
reproduce your results first.

* ntpperf with igb patch applied
Linux cml1 6.17.0-rc1+ #1 SMP PREEMPT_RT Tue Aug 19 12:56:41 CEST 2025 x86_=
64 GNU/Linux
Linux cml2 6.17.0-rc1+ #1 SMP PREEMPT_RT Tue Aug 19 12:56:41 CEST 2025 x86_=
64 GNU/Linux
root@cml1:~/ntpperf# ./ntpperf -i enp1s0 -m 6c:b3:11:52:39:15 -d 192.168.12=
3.1 -s 172.18.0.0/16 -B -H
               |          responses            |        response time (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max std=
dev
1000       100   0.00%   0.00% 100.00%   0.00%   +15124  +16491 +166838   4=
773
1500       150   0.00%   0.00% 100.00%   0.00%   +14589  +16163 +170222   4=
028
2250       225   0.00%   0.00% 100.00%   0.00%   +14337  +15825 +172604   3=
356
3375       337   0.00%   0.00% 100.00%   0.00%   +14267  +15549 +171365   2=
727
5062       506   0.00%   0.00% 100.00%   0.00%   +14033  +15389 +177490   2=
384
7593       759   0.00%   0.00% 100.00%   0.00%   +14307  +15418 +174652   1=
983
11389     1138   0.00%   0.00% 100.00%   0.00%   +14100  +16551 +169245   6=
036
17083     1708   0.00%   0.00% 100.00%   0.00%   +10077  +20077 +194647   9=
182
25624     2562   0.00%   0.00% 100.00%   0.00%   +10007  +25572 +181577  14=
952
38436     3843   0.00%   0.00% 100.00%   0.00%    +6851  +27466 +184041  14=
900
57654     5765   0.00%   0.00% 100.00%   0.00%    +5164  +29218 +246544  16=
169
86481     8648   0.00%   0.00% 100.00%   0.00%    +5346  +36063 +179512  14=
388
129721   12972   0.00%   0.00% 100.00%   0.00%    +7934  +49386 +229427  17=
600
194581   16384   0.00%   0.00% 100.00%   0.00%   +10760  +54961 +248325  18=
860
291871   16384   0.00%   0.00% 100.00%   0.00%   +13207  +57193 +248870  16=
908
437806   16384  25.42%   0.00%  74.58%   0.00%  +211479 +275061 +703480  20=
529
656709   16384  50.32%   0.00%  49.68%   0.00%  +230344 +292741 +485387  19=
119

* ntpperf without igb patch applied
Linux cml1 6.17.0-rc1+ #3 SMP PREEMPT_RT Tue Aug 19 15:31:35 CEST 2025 x86_=
64 GNU/Linux
Linux cml2 6.17.0-rc1+ #3 SMP PREEMPT_RT Tue Aug 19 15:31:35 CEST 2025 x86_=
64 GNU/Linux
root@cml1:~/ntpperf# ./ntpperf -i enp1s0 -m 6c:b3:11:52:39:15 -d 192.168.12=
3.1 -s 172.18.0.0/16 -B -H
               |          responses            |        response time (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max std=
dev
1000       100   0.00%   0.00% 100.00%   0.00%   +18246  +19931 +174292   4=
947
1500       150   0.00%   0.00% 100.00%   0.00%   +17934  +19494 +194876   4=
368
2250       225   0.00%   0.00% 100.00%   0.00%   +17969  +19254 +177394   3=
449
3375       337   0.00%   0.00% 100.00%   0.00%   +17687  +19090 +179947   2=
807
5062       506   0.00%   0.00% 100.00%   0.00%   +17798  +18999 +175463   2=
403
7593       759   0.00%   0.00% 100.00%   0.00%   +17901  +19039 +176656   1=
984
11389     1138   0.00%   0.00% 100.00%   0.00%   +17192  +20318 +184805   6=
802
17083     1708   0.00%   0.00% 100.00%   0.00%   +14241  +24428 +185137  10=
118
25624     2562   0.00%   0.00% 100.00%   0.00%    +4819  +22667 +201990   7=
962
38436     3843   0.00%   0.00% 100.00%   0.00%    +3869  +17957 +192566   8=
171
57654     5765   0.00%   0.00% 100.00%   0.00%    +2529  +14036 +173719   6=
240
86481     8648   0.00%   0.00% 100.00%   0.00%    +2774  +13642 +201026   5=
284
129721   12972   0.00%   0.00% 100.00%   0.00%    +2670  +14699 +242395   6=
692
194581   16384   0.00%   0.00% 100.00%   0.00%    +2520  +19712 +329254   9=
571
291871   16384   1.37%   0.00%  98.63%   0.00%    +2818  +77396 +15480693 1=
82286
437806   16384  24.69%   0.00%  75.31%   0.00%  +108662 +246855 +2306431  3=
8520
Could not send requests at rate 656709

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmikjy8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmSUD/4suSlfa4c60Tk9+FTIRAt6SVMVnoYB
LO9MnIc02bF4rW3pI8HAAszyIiYIBAgeC+Xei3lkxNPkXG1zWBDEPn6M/WMXvF7b
Xd6GhH6fimth9ja3kBKW6GQFSh7V0pNdTV9WsczmC6L5bPIz76Qhrek5nTA0xFHp
UzxE5uLPzAK1iiLiZuLBpBYoD1INmvZn2oKXv3xynCKE6HQHXAIozwwTM2DDseAs
xzyhnC2RXCH6GHqP0pGYLMbrwiLd8ufDK+G6C6ATNWQ4sGiK7NuKC0+zrwDxRTFH
3u/3W/tUn4/w5oYefcm/wtmfgYIZhAzucaJ+A+aGOH7Gdi2W78+KncJK65W3v8bu
H9/HXhHbv79l4AFr7671IZsLkl9Zuwtc6la8s5H/ez6qboHfOBgiCZI1JWOELg/f
VeBE4j9XHyQQKB8WSSk24VwTS7ldMN0Jjk+EOOkwHGVZFSYo2mYspvstv1OL+T/b
wgkJ/UiUPZzVWLw16WWiURVMNdf//fFOHLcNm0GAxaXKsV99USHUtj5QcvpnYExH
bvhFNUgaEbX6jlp3jn0mJWlxNiXfw5yI1AMZNVCUBzNJx+WwdZZ/Xd4V3CuLwyJI
w1VgWV6CfEfDECpHt2S96Ft+BDNrmyxNdeTH9QUgawTAyBQC9REibtmLC8xr3ThH
ls2i3MVCqkrydg==
=NvBi
-----END PGP SIGNATURE-----
--=-=-=--

