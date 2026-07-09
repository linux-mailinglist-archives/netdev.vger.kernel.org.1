Return-Path: <netdev+bounces-306017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4soDGpnzTmoNXgIAu9opvQ
	(envelope-from <netdev+bounces-306017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FA72B85D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:04:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=trager.us (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306017-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306017-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99BE53026898
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CD392C5A;
	Thu,  9 Jul 2026 00:59:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F035975
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 00:59:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558752; cv=none; b=fMLH0czIPkqeCpVnjuZ7Tcb0d78RR1MhsJ3bGHAl0fbPQAB4D0ySxF/v7DEdEL2vmtVhaeIdhTZybj7cHFCUhxhNhQKYhHIsmxoz/7OduWICJ8O7GaWgcPLWEDlNLjbJzIhVw3xmCxsO+M0F/ohOaA4d0717+FxLil9LayfeQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558752; c=relaxed/simple;
	bh=Cc0Juo1L9wo16WmyMhjIoEP4sKcaWEffGUBkjaLjUK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzoyWPTy+4XJnbi2i8IlVepYYGE5zRc7UQqyulWxr0cNXpHt63UX7aH/AmwO/FBfwQ9Glee3Z6ueK1gBeTIZu8ikjlt3OkYLmclH8TPxqk7nFHN/NkwdEHh91jyPWUVYWSZ2GTZod7ERxJcFKediBuibcfSHbcgkTpNuZGoSiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1whd6R-0007ot-L0; Thu, 09 Jul 2026 00:58:59 +0000
Message-ID: <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
Date: Wed, 8 Jul 2026 17:58:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "D H, Siddaraju" <siddaraju.dh@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
 "niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
 "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[trager.us : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lee@trager.us,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@trager.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A28FA72B85D

On 7/7/26 2:06 AM, Das, Shubham wrote:

> Thanks Andrew, Lee for the feedback.
>
> Lee,
> I don't see prbs11.0, prbs11.1, prbs11.2, prbs11.3, prbs13.0, prbs13.1, prbs13.2, prbs13.3, prbs16 and prbs32 in IEEE 802.3 2022 standard.
> Is this specific to fnic based on base PRBS pattern or it is mentioned in some other standard ?
Those were from the fbnic spec, I'm not sure where they originate from. 
I suppose we can drop those for now but its good to keep in mind more 
tests may be added in the future.
>
> Each lane and each direction is a completely separate test with its own test of
>> statistics. The test is actually verified on the Rx side, Tx is your generator so you
>> won't have data to collect. So when you run PRBS testing on a 2 lane NIC you are
>> actually running 4 independent tests.
>> While its fine to have a shortcut to run the same test on all lanes we absolutely
>> need a way to run tests per lane and the ability to choose Rx, Tx, or both.
> - Agree, we need lane parameter in commands, Updated command.
>
>
>> I wouldn't consider stats a phy-test action. It shouldn't change the state of the
>> NIC at all. I would just add phy-test-stats as set of standard ethtool statistics.
> Yes moved under separate command.
>
> Below are the updated UAPI, data structures, and Netlink messages to support PRBS/BERT and test pattern configuration.
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 5e9135e3774f..113005a5f80a 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -30,6 +30,35 @@ definitions:
> +  -
> +    name: phy-test-pattern
> +    enum-name: phy-test-pattern
> +    type: enum
> +    name-prefix: phy-test-pattern-
> +    doc: PRBS and other PHY test patterns
> +    entries:
> +      - off
> +      - prbs7
> +      - prbs9
> +      - prbs11
> +      - prbs13
> +      - prbs15
> +      - prbs23
> +      - prbs31
> +      - ssprq
> +      - prbs13q
> +      - prbs31q
> +      - square8
>
> +    name: phy-test-action
> +    enum-name: phy-test-action
> +    type: enum
> +    name-prefix: phy-test-action-
> +    doc: Actions for PHY BERT test control
> +    entries:
> +      - none
> +      - start
> +      - stop
>
> +    name: phy-test
> +    attr-cnt-name: __ethtool-a-phy-test-cnt
> +    doc: |
> +      PHY test configuration for pattern generation/checking,
> +      BERT (Bit Error Rate Test), and statistics.
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: lane
> +        type: u32
> +        doc: PHY lane index to target for the test operation
This could be a mask to allow starting and stopping the same test on 
multiple lanes at once.
> +      -
> +        name: tx-pattern
> +        type: u32
> +        doc: TX test pattern type (PRBS or square8 wave)
> +        enum: phy-test-pattern
> +      -
> +        name: rx-pattern
> +        type: u32
> +        doc: RX checker pattern type (PRBS or square8 wave)
> +        enum: phy-test-pattern
> +      -
> +        name: bert-action
> +        type: u32
> +        doc: BERT test start/stop
> +        enum: phy-test-action
> +      -
> +        name: inject-error-count
> +        type: u32
> +        doc: |
> +          Inject a specified number of bit errors into the PHY transmit data
> +          stream for diagnostic verification purposes.
> +
> +          Context and Purpose:
> +            When performing Bit Error Ratio Testing (BERT), the receiving side
> +            runs a PRBS checker that monitors for bit errors. Before relying
> +            on a zero-error BERT result, operators need to confirm Checker
> +            state and configuration to qualify result as TRUE.
> +            A checker that is broken or misconfigured would also report
> +            zero errors, giving a FALSE pass. Error injection provides this
> +            confirmation by deliberately introducing a known number of errors
> +            on the transmit side and verifying they appear on the receive side.
> +
> +            Note:
> +            Receiver under test maybe in the same port as the transmitter
> +            (loopback mode) or a different port in the same device or another
> +            device connected to the transmitting port (non-loopback mode).
> +
> +          Layer and Mechanism:
> +            Error injection operates at the PMA/PMD boundary. This is
> +            bit-level injection in the serial data stream, not frame-level.
> +            The SerDes Built-In Self Test (BIST) block inverts the specified
> +            number of bits in the outgoing serial stream. The injection does
> +            not distinguish between data frames and test patterns; it
> +            corrupts raw bits at the physical layer regardless of what the
> +            stream carries.
> +
> +          Mode of Operation:
> +            This command implements "one-shot" injection: a single burst of
> +            N bit errors injected immediately. The PHY inverts exactly N
> +            consecutive bits in the serial transmit stream at the PMA/PMD
> +            layer, then resumes clean transmission. No continuous/fixed-rate
> +            injection mode is provided.
> +
> +          Prerequisites:
> +            - A PRBS test pattern must be active on the transmitting port
> +              (tx-pattern != off).
> +            - The receiving port must have the matching rx-pattern configured
> +              and ber-lock-status must be "locked" (indicating the checker
> +              has synchronized to the incoming pattern).
> +            - BERT must be running on the receiving port (bert start issued).
> +
> +              Note:
> +              Availability of BIST mode test pattern generator, checker and
> +              lock indication is IP dependent.
> +
> +          Semantics:
> +            - Fire-and-forget: the command completes immediately. No
> +              persistent state is created. Each invocation is an independent
> +              injection event.
> +            - The command may be issued multiple times. Each invocation
> +              injects an additional burst of errors (counts accumulate on
> +              the receiver's ber-error-count across invocations).
> +            - If no test pattern is active, the behaviour is
> +              implementation-defined (hardware may silently ignore the
> +              request or return an error).
> +
> +          Expected Outcome:
> +            After injecting N errors on the TX port, the far-end receiver's
> +            ber-error-count (read via --show-phy-test) should increment by
> +            exactly N (within hardware counter precision). This confirms:
> +              1. The PRBS checker is locked and actively counting errors.
> +              2. The data path between TX and RX is intact.
> +              3. The BERT counters are functioning correctly.
> +
> +          Example Workflow:
> +            # Configure TX pattern on port A
> +            ethtool --phy-test eth1 lane 0 tx-pattern prbs31
> +            # Configure RX checker on port B, start BERT
> +            ethtool --phy-test eth2 lane 0 rx-pattern prbs31
> +            ethtool --phy-test eth2 lane 0 bert start
> +            # Verify lock
> +            ethtool --show-phy-test eth2 lane 0
> +            #   -> ber-lock-status: locked, ber-error-count: 0
> +            # Inject 5 errors from TX side
> +            ethtool --phy-test eth1 lane 0 inject-errors 5
> +            # Confirm errors were detected
> +            ethtool --show-phy-test eth2 lane 0
> +            #   -> ber-error-count: 5
> +      -
> +        name: ber-lock-status
> +        type: u8
> +        doc: PRBS lock status (1=locked, 0=not locked)
> +      -
> +        name: ber-error-count
> +        type: u64
> +        doc: BERT bit error count
> +      -
> +        name: ber-total-bits-sent
> +        type: u64
> +        doc: BERT total bits sent
nit: Hardware engineers I spoke to expect BER to be a floating point 
number which is calculated as errors / total. I dropped "BER" from 
everything kernel related to avoid confusion. I provided an awk script 
which did the calculation and provided a floating point.
> +      -
> +        name: supported-test-patterns
> +        type: u32
> +        doc: Bitmask of supported test patterns
>   
> +    -
> +      name: phy-test-act
> +      doc: |
> +        Configure PHY test parameters. Each attribute is optional and only
> +        specified attributes are applied. TX/RX patterns are set on the
> +        local port. BERT and error injection operate on the receiver port.
> +        Typical workflow:
> +          ethtool --phy-test eth1 lane 0 tx-pattern prbs7   (TX side)
> +          ethtool --phy-test eth2 lane 0 rx-pattern prbs7   (RX side)
> +          ethtool --phy-test eth2 lane 0 bert start         (start BERT on RX)
> +          ethtool --phy-test eth1 lane 0 inject-errors 10   (inject 10 errors on TX)
> +          ethtool --show-phy-test eth2 lane 0               (read counters, expect +10)
> +          ethtool --phy-test eth2 lane 0 bert stop          (stop BERT)

I think it would be good to follow what existing tools do. Lane is 
optional when not given all lanes are assumed. When specified it can be 
one or more comma separated lanes.

https://networking-docs.nvidia.com/mftswum/43018lts/mlxlink-utility

> +
> +      attribute-set: phy-test
> +
> +      do:
> +        request:
> +          attributes:
> +            - header
> +            - lane
> +            - tx-pattern
> +            - rx-pattern
> +            - bert-action
> +            - inject-error-count
> +    -
> +      name: phy-test-get
> +      doc: |
> +        Get PHY test configuration status, supported patterns, and BERT
> +        statistics (lock status, error count, total bits).
> +
> +      attribute-set: phy-test
> +
> +      do:
> +        request:
> +          attributes:
> +            - header
> +            - lane
Lane should be a mask. This way userspace can poll stats while testing 
is running which would only require one call.
> +        reply:
> +          attributes:
> +            - header
> +            - lane
> +            - tx-pattern
> +            - rx-pattern
> +            - supported-test-patterns
> +            - ber-lock-status
> +            - ber-error-count
> +            - ber-total-bits-sent
>   
>   mcast-groups:
>     list:
>
> - Shubham D
>
> From: Srinivasan, Vijay <vijay.srinivasan@intel.com>
> Sent: 02 July 2026 05:19
> To: Lee Trager <lee@trager.us>; Andrew Lunn <andrew@lunn.ch>
> Cc: Das, Shubham <shubham.das@intel.com>; Alexander Duyck <alexander.duyck@gmail.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju <siddaraju.dh@intel.com>; Chintalapalle, Balaji <balaji.chintalapalle@intel.com>; Lindberg, Magnus <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com; Wirandi, Jonas <jonas.wirandi@ericsson.com>
> Subject: Re: Ethtool : PRBS feature
>
> All good points and noted.
> Will write the specification in general terms with full description of context, usage, configuration, expected outcome etc.
>
> Vijay
>
> ________________________________________
> From: Lee Trager <mailto:lee@trager.us>
> Sent: Wednesday, July 1, 2026 4:28 PM
> To: Andrew Lunn <mailto:andrew@lunn.ch>; Srinivasan, Vijay <mailto:vijay.srinivasan@intel.com>
> Cc: Das, Shubham <mailto:shubham.das@intel.com>; Alexander Duyck <mailto:alexander.duyck@gmail.com>; Maxime Chevallier <mailto:maxime.chevallier@bootlin.com>; mailto:netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>; mailto:mkubecek@suse.cz <mailto:mkubecek@suse.cz>; D H, Siddaraju <mailto:siddaraju.dh@intel.com>; Chintalapalle, Balaji <mailto:balaji.chintalapalle@intel.com>; Lindberg, Magnus <mailto:magnus.k.lindberg@ericsson.com>; mailto:niklas.damberg@ericsson.com <mailto:niklas.damberg@ericsson.com>; Wirandi, Jonas <mailto:jonas.wirandi@ericsson.com>
> Subject: Re: Ethtool : PRBS feature
>
> On 7/1/26 3:02 PM, Andrew Lunn wrote:
>
>> On Wed, Jul 01, 2026 at 09:38:08PM +0000, Srinivasan, Vijay wrote:
>>> Hi Andrew,
>>> I think there is a disconnect here.
>> Which proves my point. The specification is not sufficient if you have
>> to keep correcting me.
>>
>> The kAPI should be understandable by somebody who has a general
>> networking background. Please write a specification with that
>> assumption in mind. Don't assume the reader is a test engineer who has
>> used PRBS for half his life. Assume it is a brand new test engineer
>> who is hearing PRBS for the first time. That is what most engineers on
>> the netdev list are. Me included.
> I think part of the disconnect is that PRBS testing is a signal
> integrity test, not a network test. In this case the phy happens to be
> Ethernet but it could just as easily be PCIE or USB. That is why it was
> heavily suggested to me at netdev 0x19 that this should be done on the
> generic phy layer, not netdev.
>
> Lee

