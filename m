Return-Path: <netdev+bounces-283812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LOuEdSO+GkVwgIAu9opvQ
	(envelope-from <netdev+bounces-283812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 980354BCD39
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323DA30131C7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633B3CB2C1;
	Mon,  4 May 2026 12:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848F1DFFD
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897166; cv=none; b=qhbI6b4Iuu4Xa5eSdd6B+b5Mcyc9/Pgzy/YKOlwNZPft26iZz37y2KaFGF6Suug9GEE+92+T3VoGPAsyrf8fyrK6QKyBlilnnWCvtfdxMb7XIbyycjxtcECqseHrTrLRm3PJOK0DAlFk4Fxm0IzpPymKHf+l0hVo/3wh3BVAloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897166; c=relaxed/simple;
	bh=GEXKO8K+vpYaFUSKcknNbWLg3aQ8xOw6r9S4Tu/SQ30=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qwjjd9U3WX/tSTH5wmgRotDbooapVqy9U1qMeXK3O+kd5tM9ZF4HXRf0pJhTN2TZjVy6s1eQ3eiZQWL1YBMlNZdZ2113f5grmkF+zaiSuIv5VZA170rd7u8//Kwj64NdjTJifoch7biDFm5dx0y78vyY3YrcEBsBMxByBULFo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d734223e4so2317770f8f.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897163; x=1778501963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i738yixxDyN+9yz1MCprknhH3NgslcUO4JTtdUMZM3A=;
        b=YFqTgXLfskMtXjBGfhzJaZIoUugOCODlllQlkdzE0GtAcqVuQS7s90hJuPhRPWIZKZ
         iUZOCFvv9ZELn+rcK8o6DfyQ6vCo4fNHV1wTgFbQUJtW0AGxSwNLOS21YVVAo6qtSJyM
         a7Y6Tj3HkiA4WcTNCZ95jWjCfq5gylaFD+aeZ9MH7W4VB9/j4cxLAVRkrRFZ9I16YhKA
         f6lvSbsFQ2ccN04vxkw5UL4KXmrSWjqX7u4mChY6iZCU5O5x1DScpCF7gvSVwHcI6+0d
         ZxEyYrgp4q/ao+WflfNvgJYwpub39jhHrL9J24mnLfB8Rq/uOaOPR+RnRlo1pOnnhrS+
         4ptw==
X-Forwarded-Encrypted: i=1; AFNElJ9ogprzKMJ0SJUGC1i/8gAdpx96AcNcW9lhH+LWcCkstfsr3JSBv+epNT08CU6OPLKhH36Ca5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kaa3CbKneg/u5NJPJFACmmCQmeqETgVH2CkqYC93lVO5kxSN
	Y9X5pirNuDwMJGemK5QZaf02Km2KFM6dOgEY02LhiPRQpn/PMBjDazvJ
X-Gm-Gg: AeBDietKn011ohNIZh8dAJzLyk9xquH2l39/yqadzcd6hf7AP2ZH6GN0kfsUbezy9ae
	laOz2Jj/UxOQNa0OMWgGogNgikluejAFSQ7L0fyVTqMcjXBhm0Pkkr5rbUnT+hmYYEKAjV6k6z9
	Ddxp8Fmto0dxamAjrZB4qnZRxoX5C93OZukydU6qm+YjA462hkD5vVb98GrDIdtUXkDw65zn1yd
	JhJmjNNaeWosSw6nLmk9U6xwZ2z4V3uwhHf2cVYvTFd3EQbWAIl6UCKMvwceGzVBnqp/DNhgraz
	u2evvVMG8zN8YzVo7BTTDU9QlmwTyA7mGZU6IF7IIdhSuwJXGabvoXGSsAfnbORC1Jpf8jCLBN2
	0B+GlMplGO34Ol3ShyMwOS3CEtC/tGsKAucCh50inUqu0At5XHVKLwmRrjSGSn31QkV/CqKDdw4
	izgTEnVveK4Iij0e9HdjqZ4VJJB6VWomShsJ/n9t14hZQQWOQbhMyiROy2PATyrxX3CxtfHGCLw
	vJv
X-Received: by 2002:a05:6000:44df:b0:43f:e56a:636e with SMTP id ffacd0b85a97d-4494fe78a09mr18078100f8f.18.1777897162777;
        Mon, 04 May 2026 05:19:22 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981ded99sm26219495f8f.18.2026.05.04.05.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:19:22 -0700 (PDT)
Message-ID: <ef01005e-d867-4936-b138-b98f37e5f394@ovn.org>
Date: Mon, 4 May 2026 14:19:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netfilter-devel@vger.kernel.org, fw@strlen.de,
 davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net 06/12] netfilter: nf_conntrack_expect: honor
 expectation helper field
To: Pablo Neira Ayuso <pablo@netfilter.org>
References: <20260326125153.685915-1-pablo@netfilter.org>
 <20260326125153.685915-7-pablo@netfilter.org>
 <8fd5d3a3-d1d7-4542-a0db-1678989940d4@ovn.org> <afSCXEg-X-ieL9cY@chamomile>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <afSCXEg-X-ieL9cY@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 980354BCD39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:mid,strlen.de:email]

On 5/1/26 12:37 PM, Pablo Neira Ayuso wrote:
> Hi Ilya,
> 
> On Thu, Apr 30, 2026 at 10:58:38PM +0200, Ilya Maximets wrote:
>> On 3/26/26 1:51 PM, Pablo Neira Ayuso wrote:
>>> The expectation helper field is mostly unused. As a result, the
>>> netfilter codebase relies on accessing the helper through exp->master.
>>>
>>> Always set on the expectation helper field so it can be used to reach
>>> the helper.
>>>
>>> nf_ct_expect_init() is called from packet path where the skb owns
>>> the ct object, therefore accessing exp->master for the newly created
>>> expectation is safe. This saves a lot of updates in all callsites
>>> to pass the ct object as parameter to nf_ct_expect_init().
>>>
>>> This is a preparation patches for follow up fixes.
>>>
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
>>> ---
>>
>> Hi, Pablo and Florian.
>>
>> I was investigating FTP test failures in OVS with 7.0 kernel and bisected
>> the issue down to this commit.  AFAIU, with this change all the related
>> connections over time gain their parents' helpers,.  This is causing a change
>> visible to the userspace, because FTP data connections are now reported to
>> have helpers in the conntrack dump:
>>
>> # conntrack -L
>> tcp      6 119 TIME_WAIT src=10.1.1.1 dst=10.1.1.2 sport=59534 dport=21 \
>>                          src=10.1.1.2 dst=10.1.1.1 sport=21    dport=59534 \
>>            [ASSURED] mark=0 helper=ftp use=2
>> tcp      6 119 TIME_WAIT src=10.1.1.2 dst=10.1.1.1 sport=52709 dport=52381 \
>>                          src=10.1.1.1 dst=10.1.1.2 sport=52381 dport=52709 \
>>            [ASSURED] mark=0 helper=ftp use=1
>>
>> Before this commit only the control connection had helper=ftp reported in
>> the dump.  The traffic seems to work fine, but our tests fail because we
>> do not expect the helper attached.
>>
>> AFAIU, it's generally not something that should be happening, as helpers
>> on data connections do not really make much sense.  But I'm just trying to
>> figure out if you would consider this as a regression and fix in the kernel
>> or if we should adjust our userspace components for this new dump content,
>> which would not be very straightforward to do if we want to be able to run
>> tests on both old and the new versions.
>>
>> What do you think?
> 
> It seems previous behaviour to 9c42bc9db90a was inconsistent, ie. only
> the h323 helper sets on exp->helper, then it shows helper= in expected
> connections via ctnetlink. I guess this is for debugging given that
> h323 is actually a family of helpers.
> 
> To consistently skip dumping this for expected connections, probably
> this is the way to do:
> 
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conn
> index eda5fe4a75c8..9491ae9e080e 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -226,7 +226,7 @@ static int ctnetlink_dump_helpinfo(struct sk_buff *sk
>         const struct nf_conn_help *help = nfct_help(ct);
>         struct nf_conntrack_helper *helper;
>  
> -       if (!help)
> +       if (!help || ct->status & IPS_EXPECTED)
>                 return 0;
>  
>         rcu_read_lock();

I'm not sure.  I tried this change and it fixed one case but broke another.
Looking at what we're testing, the old behavior (at least for FTP) was:
"if helper was committed - report it, if not - don't".  i.e. it's not really
about the connection being expected it's about if the user committed the
helper for the connection or not.

Let me explain a few scenarios that we have in the OVS system tests and what
I see with the old kernel (6.19), the new (7.0) and the patch above.

A) The first scenario has the following OpenFlow rules (simplified):

  table=0,in_port=1,tcp,action=ct(alg=ftp,commit),2
  table=0,in_port=2,tcp,action=ct(table=1)
  table=1,in_port=2,tcp,ct_state=+trk+est,action=1
  table=1,in_port=2,tcp,ct_state=+trk+rel,action=1

This set of rule blindly commits every packet coming from port 1 with the
helper and sends to port 2.  Packets from port 2 are passed through ct and
only related or established traffic is passed to port 1.  This is a very
rudimentary setup that users can make to allow ftp from port 1 towards port 2,
but not in the opposite direction.

For this scenario regardless of the kernel version or the patch above I see
that both the data and the control connections have a helper reported in the
ctnetlink dump.

B) The second scenario:

  table=0,in_port=1,tcp,action=ct(table=1)
  table=1,in_port=1,tcp,ct_state=+trk+new,action=ct(commit,alg=ftp),2
  table=1,in_port=1,tcp,ct_state=+trk+est,action=2

  table=0,in_port=2,tcp,action=ct(table=1)
  table=1,in_port=2,tcp,ct_state=+trk+new+rel,action=ct(commit),1
  table=1,in_port=2,tcp,ct_state=+trk+est,action=1

This is a more reasonable setup where new connections are committed on the
way from 1 to 2 and new related connections are committed on the way from
2 to 1.  This allows port 1 to initiate the control connection and the port
2 to initiate the related data connection.

In case of active FTP (port 1 initiates control, port 2 initiates the data):
- old:   control has the helper, data does not.
- new:   both have the helper.
- patch: control has the helper, data does not.

In case of passive FTP (port 1 initiates both the control and data):
- old:   both have the helper (because both are +new traffic from port 1).
- new:   both have the helper.
- patch: control has the helper, data does not.

C) We can modify the scenario B to avoid committing the helper on related:

  table=0,in_port=1,tcp,action=ct(table=1)
  table=1,in_port=1,tcp,ct_state=+trk+new-rel,action=ct(commit,alg=ftp),2
  table=1,in_port=1,tcp,ct_state=+trk+new+rel,action=ct(commit),2
  table=1,in_port=1,tcp,ct_state=+trk+est,action=2

  table=0,in_port=2,tcp,action=ct(table=1)
  table=1,in_port=2,tcp,ct_state=+trk+new+rel,action=ct(commit),1
  table=1,in_port=2,tcp,ct_state=+trk+est,action=1

Here we have (same for active and passive):
- old:   control has the helper, data does not.
- new:   both have the helper.
- patch: control has the helper, data does not.

I hope that clarifies the situation a little bit.

So, if we want to restore the old behavior, the we'd probably need to track
how connection gained the helper, i.e. was it via commit or was it inherited.

I'm also not sure why we see the helper with the patch above in scenario A that
commits established traffic, but not in B or C that only commits new traffic.

Best regards, Ilya Maximets.

