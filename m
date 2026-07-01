Return-Path: <netdev+bounces-303904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OULIAS+rRWq0DgsAu9opvQ
	(envelope-from <netdev+bounces-303904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:05:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A7B6F28AE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:05:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=trager.us (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303904-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303904-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E06303E4B6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CCE239E9B;
	Thu,  2 Jul 2026 00:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E979191
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 00:01:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950488; cv=none; b=aHOxyfamZvk+whkS+BATx9bgg+OJstZfM6UAjzWrUX7zskgepbVoaLWP3Cw2OMnqld0OgqJEkNwWeUCF9/MkVelYYojuBM80UzymcWHkX6VKhkHTWdXg5uLj2vlgTuAyHtfQb1axJcd8RFDfPkZ6MDFN3dz0p+BfA+ZTDsPQUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950488; c=relaxed/simple;
	bh=eBQXp6FLhpisDQvZnyTq+wfHMSYFskHvVGP2Z7Hcff4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4R7NnTBAVywTespTFcFNYBObEgLLkq8MOKn5wklTFvTDAA1Z+Z4iHQ8ogBnve17pca7Q0nNZHuKXj0e7X6DKqfvqn8DFmXQsZeR51N6kjRecSrOJXE/6glXBOvrWwbLJPcRUJkN925DzbsQaBO7iF5VAGAPZlm2z0YbxbisKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wf49U-0003fR-EX; Wed, 01 Jul 2026 23:15:32 +0000
Message-ID: <4efe1cbe-a4e6-4d05-b2cb-ae6daee61833@trager.us>
Date: Wed, 1 Jul 2026 16:15:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "D H, Siddaraju" <siddaraju.dh@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
 "niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
References: <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[trager.us : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:alexander.duyck@gmail.com,m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,lunn.ch];
	FORGED_SENDER(0.00)[lee@trager.us,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-303904-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@trager.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ericsson.com:email,intel.com:email,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84A7B6F28AE

On 6/29/26 9:15 AM, Das, Shubham wrote:

> Hi All,
>
> Below are the proposed modifications to the UAPI, data structures, and Netlink messages to support PRBS/BERT and test pattern configuration.
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 5e9135e3774f..cb11e139dd81 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -30,6 +30,36 @@ definitions:
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

fbnic supports a number of other tests as well. Getting the full list of 
common PRBS tests codified would be ideal

- prbs11.0

- prbs11.1

- prbs11.2

- prbs11.3

> +      - prbs13

  - prbs13.0

- prbs13.1

- prbs13.2

- prbs13.3

> +      - prbs15
- prbs16
> +      - prbs23
> +      - prbs31
- prbs32
> +      - ssprq
> +      - prbs13q
> +      - prbs31q
> +      - square
> +  -
> +    name: phy-test-action
> +    enum-name: phy-test-action
Each lane and each direction is a completely separate test with its own 
test of statistics. The test is actually verified on the Rx side, Tx is 
your generator so you won't have data to collect. So when you run PRBS 
testing on a 2 lane NIC you are actually running 4 independent tests. 
While its fine to have a shortcut to run the same test on all lanes we 
absolutely need a way to run tests per lane and the ability to choose 
Rx, Tx, or both.
> +    type: enum
> +    name-prefix: phy-test-action-
> +    doc: Actions for PHY BERT test control
> +    entries:
> +      - none
> +      - start
> +      - stop
> +      - stats
I wouldn't consider stats a phy-test action. It shouldn't change the 
state of the NIC at all. I would just add phy-test-stats as set of 
standard ethtool statistics.
>     -
>       name: header-flags
>       type: flags
> @@ -1818,6 +1848,58 @@ attribute-sets:
>           type: u32
>           enum: loopback-type
>   
> +  -
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
> +        name: tx-pattern
> +        type: u32
> +        doc: TX test pattern type (PRBS or square wave)
> +        enum: phy-test-pattern
> +      -
> +        name: rx-pattern
> +        type: u32
> +        doc: RX checker pattern type (PRBS or square wave)
> +        enum: phy-test-pattern
> +      -
> +        name: bert-action
> +        type: u32
> +        doc: BERT test start/stop/stats
> +        enum: phy-test-action
> +      -
> +        name: inject-error-count
> +        type: u32
> +        doc: |
> +          Number of errors to inject. Each invocation injects the specified
> +          number of bit errors into the data stream.
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
> +        doc: BERT total bits tested
> +      -
> +        name: supported-test-patterns
> +        type: u32
> +        doc: Bitmask of supported test patterns
Again all of this needs to be per lane.
>   
>     -
>       name: phy-tunable
> @@ -2924,6 +3006,53 @@ operations:
>              - header
>              - enabled
>              - type
> +    -
> +      name: phy-test-act
> +      doc: |
> +        Configure PHY test parameters. Each attribute is optional and only
> +        specified attributes are applied. TX/RX patterns are set on the
> +        local port. BERT and error injection operate on the receiver port.
> +        When bert-action is stats, a reply with BERT counters is returned.
> +        Typical workflow:
> +          ethtool --phy-test eth1 tx-pattern prbs7  (TX side)
> +          ethtool --phy-test eth2 rx-pattern prbs7  (RX side)
> +          ethtool --phy-test eth2 bert start        (start BERT on RX)
> +          ethtool --phy-test eth2 bert stats        (read counters and lock status)
> +          ethtool --phy-test eth2 bert stop         (stop BERT)
> +
> +      attribute-set: phy-test
> +
> +      do:
> +        request:
> +          attributes:
> +            - header
> +            - tx-pattern
> +            - rx-pattern
> +            - bert-action
> +            - inject-error-count
> +        reply:
> +          attributes:
> +            - header
> +            - ber-lock-status
> +            - ber-error-count
> +            - ber-total-bits-sent
> +    -
> +      name: phy-test-get
> +      doc: |
> +        Get PHY test configuration status and supported patterns.
> +
> +      attribute-set: phy-test
> +
> +      do:
> +        request:
> +          attributes:
> +            - header
> +        reply:
> +          attributes:
> +            - header
> +            - tx-pattern
> +            - rx-pattern
> +            - supported-test-patterns
>   
>   mcast-groups:
>     list:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 1ac85b8aebd7..3bcca506cf7b 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
>
> +/* Bitmask of which ethtool_phy_test fields were explicitly specified */
> +#define PHY_TEST_CMD_TX_PATTERN		    BIT(0)
> +#define PHY_TEST_CMD_RX_PATTERN		    BIT(1)
> +#define PHY_TEST_CMD_BERT_ACTION	    BIT(2)
> +#define PHY_TEST_CMD_INJECT_COUNT	    BIT(3)
> +
> +/**
> + * struct ethtool_phy_test - PHY test configuration and status
> + * @cmd: Bitmask of PHY_TEST_CMD_* indicating which fields to apply (SET)
> + * @tx_pattern: TX test pattern
> + * @rx_pattern: RX checker pattern
> + * @bert_action: BERT start/stop/stats action
> + * @inject_error_count: Number of bit errors to inject (SET only)
> + * @supported_test_patterns: Bitmask of supported patterns (GET only)
> + * @ber_lock_status: BER lock status 1=locked, 0=not locked (GET only)
> + * @ber_error_count: BERT bit error count (GET only)
> + * @ber_total_bits_sent: BERT total bits tested (GET only)
> + */
> +struct ethtool_phy_test {
> +	u32 cmd;
> +	enum phy_test_pattern tx_pattern;
> +	enum phy_test_pattern rx_pattern;
> +	enum phy_test_action bert_action;
> +	u32 inject_error_count;
> +	u32 supported_test_patterns;
> +	u8 ber_lock_status;
> +	u64 ber_error_count;
> +	u64 ber_total_bits_sent;
> +};
> +
>   /**
>    * struct ethtool_ops - optional netdev operations
>    * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
> @@ -1091,7 +1121,8 @@ struct ethtool_loopback {
>    * @get_mm: Query the 802.3 MAC Merge layer state.
>    * @set_mm: Set the 802.3 MAC Merge layer parameters.
>    * @get_mm_stats: Query the 802.3 MAC Merge layer statistics.
> - *
> + * @get_phy_test: Get PHY test status, patterns, and BERT counters.
> + * @set_phy_test: Configure PHY test (pattern, BERT, error injection). *
>    * All operations are optional (i.e. the function pointer may be set
>    * to %NULL) and callers must take this into account.  Callers must
>    * hold the RTNL lock.
> @@ -1260,6 +1291,10 @@ struct ethtool_ops {
>   	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
> +	int	(*get_phy_test)(struct net_device *dev,
> +				struct ethtool_phy_test *test);
> +	int	(*set_phy_test)(struct net_device *dev,
> +				struct ethtool_phy_test *test);
>   };
>
>
> The 'tx_prbs' and 'rx_prbs' command parameters have been renamed to 'tx_pattern' and 'rx_pattern' to allow support
> for additional test patterns defined in the RFC, such as square patterns, in addition to PRBS.
>
> The statistics have been moved to the 'ber' test command.
>
> I also think it would be better to expose 'tx_pattern' and 'rx_pattern' as separate commands,
> since the TX and RX ports can be different. They are only the same when operating in loopback mode.
>
>
>> You need to think about the units for inject errors. There is no floating point support. Also, is this corrupt packets?
>> Or single bit flips in the stream? It needs to be well defined what it actually means. The driver can then convert it to whatever the hardware supports. How does 802.3 specify this?
> I believe it is not mentioned in IEEE specs, But it will be helpful in debug in both data and PRBS mode.
> Maybe we can have number of errors injected in steam when we issue command rather than error rate ?
>
>
>> Traditionally, Unix does not offer a way to clear statistic counters back to zero. So i'm not sure about clear-stats.
>> We also need to think about hardware which does not support that. And there is locking issues, can the stats be cleared while a test is active?
> I think we can auto clear in PHY FW or in implementation when we start the test.
>
> Also, as previously suggested we need new status to indicate device is under test for net device.
>   
> - Shubham D
>
>> -----Original Message-----
>> From: Alexander Duyck <alexander.duyck@gmail.com>
>> Sent: 24 June 2026 21:06
>> To: Andrew Lunn <andrew@lunn.ch>
>> Cc: Lee Trager <lee@trager.us>; Das, Shubham <shubham.das@intel.com>;
>> Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org;
>> mkubecek@suse.cz; D H, Siddaraju <siddaraju.dh@intel.com>; Chintalapalle,
>> Balaji <balaji.chintalapalle@intel.com>; Lindberg, Magnus
>> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
>> Subject: Re: Ethtool : PRBS feature
>>
>> On Tue, Jun 23, 2026 at 7:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>>      To avoid race conditions, maybe some of these commands need combining.
>>>>      ethtool --phy-test eth1 tx-prbs prbs7 rx-prbs prbs7 bert start
>>>>
>>>>      The configuration is then atomic, with respect to the uAPI, so we
>>>>      don't get two users configuring it at the same time, ending up with a
>>>>      messed up configuration.
>>>>
>>>> Testing consumes the link so you really don't want anything done to
>>>> the netdev while testing is running. fbnic does the following.
>>>>
>>>> 1. Testing cannot start when the link is up
>>> That is not going to work in the generic case. Many MAC drivers don't
>>> bind to there PCS or PHY until open() is called. So there is no way to
>>> pass the uAPI calls onto the PCS or PHY if the interface is down.
>>> There are also some MACs which connect to multiple PCSs, and there can
>>> be multiple PHYs. So you need to somehow indicate which PCS/PHY should
>>> perform the PRBS. There was a discussion about loopback recently,
>>> which has the same issue, you can perform loopback testing in multiple
>>> places. So i expect the same concept will be used for this.
>> I would think something like this would still be usable. You would just need to
>> specify the phy address and possibly device address in the case that you support
>> doing such testing at multiple layers.
>> Basically it would be up to the driver to provide a way to connect the request with
>> the desired interface. I would imagine something similar is the case for the
>> loopback handling since there are so many layers where you can hairpin things
>> back to the port it came in on.
>>
>>>> 2. Once testing starts the driver removes the netdev to prevent use.
>>>> The netdev is only added back when testing stops. The upstream
>>>> solution will need something that can keep the netdev but lock
>>>> everything down while testing is running.
>>> Probably IF_OPER_TESTING would be part of this. If the interface is in
>>> this state, you want many other things blocked. However, probably
>>> ksettings get/set need to work, so you can force the link into a
>>> specific mode.
>> I would imagine it depends on if you want to enforce ordering on this or not. I
>> would say the set would probably need to be blocked as you wouldn't normally
>> want to be changing the setting in the middle of a test as it would cause the error
>> stats to climb quickly.
>>
>>>> 3. Once testing starts you cannot change the test, even on an
>>>> individual lane basis. You must stop testing first.
>>>>
>>>>
>>>>      Traditionally, Unix does not offer a way to clear statistic counters
>>>>      back to zero. So i'm not sure about clear-stats. We also need to think
>>>>      about hardware which does not support that. And there is locking
>>>>      issues, can the stats be cleared while a test is active?
>>>>
>>>> fbnic actually has separate registers for PRBS test results. Results
>>>> do need to be clean between runs but I never created an explicit
>>>> clear interface. Firmware automatically reset the registers when a
>>>> new test was started. This also allows results to be viewed after testing has
>> stopped.
>>> We should really take 802.3 as the model, but i've not had time yet to
>>> read what it says about the statistics.
>> I think most of this is all called out in the IEEE 802.3-2022 spec under section
>> 45.2.1.169 - 45.2.1.174. Basically the ability and controls live in the 1500 range,
>> Tx error statistics in the 1600, and Rx statistics in the 1700 range.
>>
>>>> Reading results was a little tricky due to roll over between two
>>>> 32bit registers.
>>> 802.3 is make this even more interesting, since those registers are 16
>>> bits.
>> Yeah, normally to deal with something like that we would likely be looking at
>> having to maintain a fairly high read frequency. Although in theory the error
>> counts shouldn't be climbing that fast anyway. The spec calls out that the registers
>> are clear on read and held at ~0 in the event of overflow which would be a failing
>> case for any reasonable test anyway.
>>
>>>> When I spoke to hardware engineers at Meta they did not want a
>>>> timeout. Testing often occurred over days, so they wanted to be able
>>>> to start it and explicitly stop it. I'm not against a time out but I do think it
>> should be optional.
>>>> Since PRBS testing is handled by firmware one safety measure I added
>>>> is if firmware lost contact with the host testing was automatically
>>>> stopped and TX FIR values were reset to factory. This ensured that
>>>> the NIC won't get stuck in testing and on initialization the driver
>>>> doesn't have to worry about testing state.
>>> That will work for firmware, but not when Linux is driving the
>>> hardware. I don't know if netlink will allow it, or if RTNL will get
>>> in the way etc, but it could be we actually don't want a start and
>>> stop commands at all, it is a blocking netlink call, and the test runs
>>> until the user space process closes the socket?
>> What we would probably need to do is look at testing as a state rather than an
>> operation. Basically the NIC would be put into the testing state and as a result it
>> would just be sitting there emitting whatever test pattern it is supposed to emit,
>> and validating it is receiving the pattern it expects to receive.
>>
>> The statistics could probably just be a subset of the PHY statistics that could be
>> collected separately. Actually now that I think about it I wonder if we couldn't
>> look at putting together the interface similar to how we currently handle FEC
>> where you have the --set-fec interface to configure things and the --show-fec
>> interface with the -I option to show the current state and also dump the
>> statistics.

