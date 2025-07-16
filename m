Return-Path: <netdev+bounces-207510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4947B079F8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2651895D2B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8590C2727F6;
	Wed, 16 Jul 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="qhGR7x9F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDGdDLZf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47625CC64;
	Wed, 16 Jul 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679809; cv=none; b=NqaFKzuoZYvzbasuTsgbemgvN1Iu2gZ7dhVem7eug0bDTX6QLrzVH+SQ3nxpoH2ASDOWNqbxJG5+tWGolk6pFjeFJPwO0LCJB2onaDgUDYWuAt6ahPP1CzTU+obSfwVcoZJb8KkvrNGwGPDE3NVLx+iYtPecfwhqzzNVDrWX4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679809; c=relaxed/simple;
	bh=q19oPmWx4ndYXqFXTTEyUsJjjhRv7hd5EVZtq80+VRM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=asjtLnmDu0DuPu+oustD2ZNQL/CQQqGW9/ciDKn1NNW6G2DyEkb33aWO7N9W10/YugMGStV7pymPX69e+uvLSOrdj488sxnNgFPb6TBHFyRZ1bTuTbjP4yjuGH91iY7gkdxqtdMwjEKiYtfZZjrvWaQscSZieS70GRunr34lCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=qhGR7x9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDGdDLZf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EF3AEC018D;
	Wed, 16 Jul 2025 11:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 11:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1752679805; x=1752766205; bh=fM/6R+vfgRGsY/e2e3ZTsuUh1AGxohtC
	hKt9/g8gh2Q=; b=qhGR7x9FOaEUbeRstB4QHp1l8lxdHfmfG/aE+kntJsrWKtgA
	kIEK/tVNTHsSbAx8J4VoXWLTMlgFP0vVA5vW65jFRY+U6GMuyS72EPzI3cwktTQn
	8OLuM1nXOwcWW2LeO8zPVqRMVUrBMSDFeSidkyG4gzl1xNsmYk6MFSpo1c8d46Sk
	98DkW5shsnEAkywCRQnYnSzvCOpZ6zN507S59cyeHWNeu58qmm6UdnvqCXWUhO4Z
	RLINSEByJ6tlmEw9lokTFsj6+pyOPQtdiYWVgXJwbzM2z/E1CTOcL7jb21GSEa+B
	QtO6w0yHTRhDpkzjlfbU3vJMum2HCHLiX4qKOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752679805; x=
	1752766205; bh=fM/6R+vfgRGsY/e2e3ZTsuUh1AGxohtChKt9/g8gh2Q=; b=C
	DGdDLZfn34ciuyNA68v+v5aEJ4EBSI6al90mSakDNLR3gVv8hzeWq41dbyZ2ze0E
	5XzZzoWrOJBW/426pO2KVBgZUYWkC5r48+wzkVOncaiP5hBKLRe8upEFeHSgxxgu
	Q3c212FH5EdUfzTLRsc24lGfe3sY9X8V6Wqhh5gfOQTryShCcI0cUMylCs2VJRB4
	w1FIv5aP1jk7PS4qR2+XQiErHjCANqSzf+nZQAQ8xyAkBkNtPwXISH5kOVt94Jpa
	wcCfnOGVqfZFm63LIn3DLdenw1W2MWPpzZVZBurQdF/ssma+KUpZfVq5FRunN+IP
	O5uDzolCP2H6aunDyIWcQ==
X-ME-Sender: <xms:fMV3aEmJTztibKi7FV4MEY5mufYmwS7K1lQO46S2ikPDitG3n_vvNg>
    <xme:fMV3aMdNz4ranuwPiqXrp-2iwO52OgqRIWnn9sMbA5qmHomrdQwV77J4-AZ7_BP6Q
    Ro4VAf2xgULqY0fsxw>
X-ME-Received: <xmr:fMV3aKG6fZZfTKjaFFdZNj4ELXAln_I9kPkggrK7ZZcltAMo4JkYCripIz3eTkzhvaZ2VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghrlhho
    shdrsghilhgsrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhfohhrshhhvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurh
    gvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fMV3aKg3bIMSZJc8z7hfJHTOq40r7e17s-izlvNz2Wo6uOFPxqBUPQ>
    <xmx:fMV3aG0NJuu0Uh-B2Y62OotsB38bIOaRzrhexcXG4-51euwE8EExWw>
    <xmx:fMV3aNfeEP5tbYF07I9s8aPe4mRFVh2OHw6HtMQ7SbUcAFArYKEPfw>
    <xmx:fMV3aMxIRmgZNZ2lEgpsnc9-fnoJHHKXG31rZ4Z8Q1CLa1Uqp-b5SQ>
    <xmx:fcV3aI-IXI2mlyOyzmHdo2YbjtM5GADuNEhc2lTSMGTiGpyRcDMCPVEY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:30:04 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 0B2EA9FC97; Wed, 16 Jul 2025 08:30:03 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0A1129FB65;
	Wed, 16 Jul 2025 08:30:03 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Carlos Bilbao <bilbao@vt.edu>
cc: carlos.bilbao@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    horms@kernel.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, sforshee@kernel.org
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from counter to jiffies
In-reply-to: <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org> <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
Comments: In-reply-to Carlos Bilbao <bilbao@vt.edu>
   message dated "Tue, 15 Jul 2025 15:59:39 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jul 2025 08:30:03 -0700
Message-ID: <798952.1752679803@famine>

Carlos Bilbao <bilbao@vt.edu> wrote:

>FYI, I was able to test this locally but couldn=E2=80=99t find any kselfte=
sts to
>stress the bonding state machine. If anyone knows of additional ways to
>test it, I=E2=80=99d be happy to run them.

	Your commit message says this change will "help reduce drift
under contention," but above you say you're unable to stress the state
machine.

	How do you induce "drift under contention" to test that your
patch actually improves something?  What testing has been done to insure
that the new code doesn't change the behavior in other ways (regressions)?

	Without a specific reproducable bug scenario that this change
fixes, I'm leery of applying such a refactor to code that has seemingly
been working fine for 20+ years.

	I gather that what this is intending to do is reduce the current
dependency on the scheduling accuracy of the workqueue event that runs
the state machines.  The current implementation works on a "number of
invocations" basis, assuming that the event is invoked every 100 msec,
and computes various timeouts based on the number of times the state
machine runs.

	-J

>Thanks!
>
>Carlos
>
>On 7/15/25 15:57, carlos.bilbao@kernel.org wrote:
>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>
>> Replace the bonding periodic state machine for LACPDU transmission of
>> function ad_periodic_machine() with a jiffies-based mechanism, which is
>> more accurate and can help reduce drift under contention.
>>
>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>> ---
>>   drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>>   include/net/bond_3ad.h         |  2 +-
>>   2 files changed, 32 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
>> index c6807e473ab7..8654a51266a3 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *por=
t, struct bond_params *bond_para
>>   	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(p=
ort->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>>   	    !bond_params->lacp_active) {
>>   		port->sm_periodic_state =3D AD_NO_PERIODIC;
>> -	}
>> -	/* check if state machine should change state */
>> -	else if (port->sm_periodic_timer_counter) {
>> -		/* check if periodic state machine expired */
>> -		if (!(--port->sm_periodic_timer_counter)) {
>> -			/* if expired then do tx */
>> -			port->sm_periodic_state =3D AD_PERIODIC_TX;
>> -		} else {
>> -			/* If not expired, check if there is some new timeout
>> -			 * parameter from the partner state
>> -			 */
>> -			switch (port->sm_periodic_state) {
>> -			case AD_FAST_PERIODIC:
>> -				if (!(port->partner_oper.port_state
>> -				      & LACP_STATE_LACP_TIMEOUT))
>> -					port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>> -				break;
>> -			case AD_SLOW_PERIODIC:
>> -				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
>> -					port->sm_periodic_timer_counter =3D 0;
>> -					port->sm_periodic_state =3D AD_PERIODIC_TX;
>> -				}
>> -				break;
>> -			default:
>> -				break;
>> -			}
>> -		}
>> +	} else if (port->sm_periodic_state =3D=3D AD_NO_PERIODIC)
>> +		port->sm_periodic_state =3D AD_FAST_PERIODIC;
>> +	/* check if periodic state machine expired */
>> +	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
>> +		/* if expired then do tx */
>> +		port->sm_periodic_state =3D AD_PERIODIC_TX;
>>   	} else {
>> +		/* If not expired, check if there is some new timeout
>> +		 * parameter from the partner state
>> +		 */
>>   		switch (port->sm_periodic_state) {
>> -		case AD_NO_PERIODIC:
>> -			port->sm_periodic_state =3D AD_FAST_PERIODIC;
>> -			break;
>> -		case AD_PERIODIC_TX:
>> -			if (!(port->partner_oper.port_state &
>> -			    LACP_STATE_LACP_TIMEOUT))
>> +		case AD_FAST_PERIODIC:
>> +			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>>   				port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>> -			else
>> -				port->sm_periodic_state =3D AD_FAST_PERIODIC;
>> +			break;
>> +		case AD_SLOW_PERIODIC:
>> +			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>> +				port->sm_periodic_state =3D AD_PERIODIC_TX;
>>   			break;
>>   		default:
>>   			break;
>> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *por=
t, struct bond_params *bond_para
>>   			  "Periodic Machine: Port=3D%d, Last State=3D%d, Curr State=3D%d\n",
>>   			  port->actor_port_number, last_state,
>>   			  port->sm_periodic_state);
>> +
>>   		switch (port->sm_periodic_state) {
>> -		case AD_NO_PERIODIC:
>> -			port->sm_periodic_timer_counter =3D 0;
>> -			break;
>> -		case AD_FAST_PERIODIC:
>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>> -			port->sm_periodic_timer_counter =3D __ad_timer_to_ticks(AD_PERIODIC_=
TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
>> -			break;
>> -		case AD_SLOW_PERIODIC:
>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>> -			port->sm_periodic_timer_counter =3D __ad_timer_to_ticks(AD_PERIODIC_=
TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
>> -			break;
>>   		case AD_PERIODIC_TX:
>>   			port->ntt =3D true;
>> -			break;
>> +			if (!(port->partner_oper.port_state &
>> +						LACP_STATE_LACP_TIMEOUT))
>> +				port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>> +			else
>> +				port->sm_periodic_state =3D AD_FAST_PERIODIC;
>> +		fallthrough;
>> +		case AD_SLOW_PERIODIC:
>> +		case AD_FAST_PERIODIC:
>> +			if (port->sm_periodic_state =3D=3D AD_SLOW_PERIODIC)
>> +				port->sm_periodic_next_jiffies =3D jiffies
>> +					+ HZ * AD_SLOW_PERIODIC_TIME;
>> +			else /* AD_FAST_PERIODIC */
>> +				port->sm_periodic_next_jiffies =3D jiffies
>> +					+ HZ * AD_FAST_PERIODIC_TIME;
>>   		default:
>>   			break;
>>   		}
>> @@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port, =
int lacp_fast)
>>   		port->sm_rx_state =3D 0;
>>   		port->sm_rx_timer_counter =3D 0;
>>   		port->sm_periodic_state =3D 0;
>> -		port->sm_periodic_timer_counter =3D 0;
>> +		port->sm_periodic_next_jiffies =3D 0;
>>   		port->sm_mux_state =3D 0;
>>   		port->sm_mux_timer_counter =3D 0;
>>   		port->sm_tx_state =3D 0;
>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>> index 2053cd8e788a..aabb8c97caf4 100644
>> --- a/include/net/bond_3ad.h
>> +++ b/include/net/bond_3ad.h
>> @@ -227,7 +227,7 @@ typedef struct port {
>>   	rx_states_t sm_rx_state;	/* state machine rx state */
>>   	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
>>   	periodic_states_t sm_periodic_state;	/* state machine periodic state =
*/
>> -	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter=
 */
>> +	unsigned long sm_periodic_next_jiffies;	/* state machine periodic next=
 expected sent */
>>   	mux_states_t sm_mux_state;	/* state machine mux state */
>>   	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
>>   	tx_states_t sm_tx_state;	/* state machine tx state */

---
	-Jay Vosburgh, jv@jvosburgh.net


