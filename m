Return-Path: <netdev+bounces-259704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLVvHKpSmGk1GQMAu9opvQ
	(envelope-from <netdev+bounces-259704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:25:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9216779A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5949C3052BAE
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014E342C9E;
	Fri, 20 Feb 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nd1iv9h8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76E34320A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590309; cv=none; b=uEp/j8ygfZtasB1+BsOADW2AgwrKRAdFMdAe5kKT6A0bs9h65nNICZC89j21EoS1XI2pvt/a0ZRZQdNTdnEkcU8uau50ukEzrsUPTYVw8GHFLa+J50McsxfzWTV/TgDuYanzdmz6cv71B3smpWk+RLSfF+5f8YRwk2/DChMnZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590309; c=relaxed/simple;
	bh=TaLjfvOzj/HIcOTUm6OJh917piL4hDV/FfEgkrsrmK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkr4/J1A8ItB43iMckjIgvNuqMLOErwq2Lv8RHtt50Lt0mtIeTpMTN60X9/+34XDegDwehM86pkHUwhW9FHTIHFTGCvtk7QsXwynDm++MeDbRNmXjtskWpfUwRkaGCP4YUd09vAw6kfTpWu+EHKXQxOqJ3UVnJZcAiXQKcXkLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nd1iv9h8; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948a378b9deso569879241.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771590306; x=1772195106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUjuCPulvrU/V53TQvaDZPT3PxcDMvlKYGaXtuHsTLY=;
        b=nd1iv9h8JSTZNP2pSPL4tsVPDjAtXO+n6c/vaiuMBBUdM0Cg5k1+uQClAcgkld80zk
         q0pbIcxVtbB9KY7lM5Jf21yZAtJ7Qgce3fhPz0rGeEf1dBIpjzClmNVAWXImivZpZpmz
         Y3wuQgnOmD1/YgwHk6sQuitPwXcNpyC5N1dqK6VwQeecoQner5LfM1JkKnhDdJdRv2gp
         zo4uq3uBGnJgqz9CdPcwkz8JGbfQKi1bamKwn0W/B0i7AUtwaxqqCXxONpdXTZF/vGKP
         3AjRJ5bou3JbVN62KO5l9ZCAzYAkGUu4Gio65ACdM28jCWLOLOEBlH+xS321jiy9PvFu
         Vz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771590306; x=1772195106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUjuCPulvrU/V53TQvaDZPT3PxcDMvlKYGaXtuHsTLY=;
        b=a3icu6miQl6yy+uSykS/iZYeAx0Bj2F2WSjL6uDen7cWGatvk9A5ilFFL7pwI4SEXr
         ya+zB9EVuGhFZ3i0fRKVIibIHPy7T6EesRIgedtQaGcSCbh0dDn5VCxzXqiBTEGbLzSO
         k3j3PFAfbx9loFBILHsv8OO5PPmwf7w9C6JUBq6xbypk67mcqZE+Iuu3Hx6GmvyAopxr
         BQYwBmUsjV2my00rBA8Ll3XNf3wXWFrnUS3YWJ+WXjn1/7CKC40qQc3wQ4cOjJUsKfLN
         2/a1OjG9KiPWy328IOW8homnAWb/tBpo5hAux1DNMl5wDx/yTAUtABE2Ud4WZyxt49tl
         4Hig==
X-Forwarded-Encrypted: i=1; AJvYcCWwM+E7ddUc3XSRLat43ijDbwCWGtJ5LrAMIPvQhRpIOq6MXDZJJ9qGgILLsmSAO+sAc2c8nHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VvELFOmHVb8UTUZhSqtEXXEbdG8FHwEN6t1iwCNFIfvQq11S
	+gV0ilJqXMp1qjpsWC7tHsR5s82JfRKbeJnNe5Zwo6eOW+FKMrwPTmwH+AzCpa5ErA==
X-Gm-Gg: AZuq6aIp1Mq9M/552ioZaeZdH6hMpORULo9XoPDW163aoq4YzSEnbIPTrITugcyZ9zo
	OsJ7PWhl8s6JeuHO0QvTgYGT/+1g01LJUV7t1HGmV8NkYKya6O5l6enb+uB+fgHiIFj1iMLL2xN
	JorZq96LUDW/Ba3B9v8lDysIjp0kRfLZLvrVS0fwZ+QyLcy6zOSCg80a8w/GUIMjwm82ToOFvGu
	DBrkUns8gm4Siqljb3dd0BDs1cCQILgQRdndEkKHTjVrMt/+Q9Mvfz118g60JODss/UI4Xp+xLK
	dIWOEW5W7qlJ8mu+5ELscJJOT8BRNseIIzssMlPfTIC7sqG9+QtICdaJjHR6ftNoP0OM8a2QSfu
	PapVyxJH3NLcavctSR2Ifj4xwc5SWErfMoCWTXpP2rF2tb4mwylnhHWJNn+2YTFkRWs+Js2AXqB
	OI6nRKbM2kDPNr3cCyg4GgsYQDLWYy+i8C3cglDI4b9fJ7
X-Received: by 2002:a05:6102:e06:b0:5f9:39e6:cb04 with SMTP id ada2fe7eead31-5fe2acee59amr6908988137.9.1771590306169;
        Fri, 20 Feb 2026 04:25:06 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::2000? ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd14e0b7sm16093007241.3.2026.02.20.04.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 04:25:05 -0800 (PST)
Message-ID: <b4b43d1d-00bc-4168-8204-88bd9b0ba9a1@mojatatu.com>
Date: Fri, 20 Feb 2026 09:24:59 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
 <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
 <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org>
 <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
 <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
 <CAM0EoMmq-aN98=TTh7YkODFr2DmZjD=Lzp6roGiCBog1tT9Lyw@mail.gmail.com>
 <CAM0EoMn_eXtLi36Nb3Y=oHCN3dNRjhB0UMwGVhZkr4zbAkxzuA@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMn_eXtLi36Nb3Y=oHCN3dNRjhB0UMwGVhZkr4zbAkxzuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCF9216779A
X-Rspamd-Action: no action

On 19/02/2026 17:13, Jamal Hadi Salim wrote:
> On Thu, Feb 19, 2026 at 9:16 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Wed, Feb 18, 2026 at 3:43 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
>>>> On Wed, Feb 18, 2026 at 1:31 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>>> On Wed, Feb 18, 2026 at 11:15 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>  From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
>>>>>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
>>>>>> for the application that makes a request and for the user if they make
>>>>>> the request manually with 'tc filter ...'.
>>>>
>>>>> The challenge is actions could be created as a standalone i.e "tc
>>>>> actions add action ct..." then later bound via tc filter. Don't forget
>>>>> actions can also be shared by multiple filters (which could be a mix
>>>>> of egress/ingress)...
>>>>
>>>> Actually, looking closely at the code - this is doable. Let's see if a
>>>> patch can be cooked.
>>>
>>> I discussed a bit the topic with Davide, it looks like the thing you
>>> mentioned above could be handled. The problematic part is AFAICS the
>>> additional indirection level added by (possibly shared) blocks. AFAICS
>>> whatever check we do at ct_init() time, shared block could later
>>> circumvent it - unless act_ct is always forbidden for shared blocks.
>>>
>>> TL;DR: I think admission check at init time can be implemented only in a
>>> quite (too much?) restrictive way.
>>>
>>
>> True - the blocks will require more surgery but seems doable. We may
>> end up again in ->quirks() land here. I.e when an action is bound to a
>> filter (not necessarily when created) it should check its fit in the
>> graph and see if it is legit. But since this is only the second quirk
>> we know of, we can simplify. Note: We already have one such check,
>> albeit ugly-looking, with skbedit (see flag TCA_ACT_FLAGS_AT_INGRESS).
>> I will talk to Victor and see if he can cook at minimal a preliminary
>> patch without considering blocks, and at best one that does consider
>> blocks.
> 
> After discussions with Victor we concluded that blocks have no effect
> on this specific issue.
> Blocks are only useful in clsact(both ingress/egress) and ingress.
> Both of these handle ACT_CONSUMED fine.
> Code sample looks as follows:
> 
>          case TC_ACT_STOLEN:
>          case TC_ACT_QUEUED:
>          case TC_ACT_TRAP:
>                  consume_skb(skb);
>                  fallthrough;
>          case TC_ACT_CONSUMED:
>                  *ret = NET_RX_SUCCESS;
>                  bpf_net_ctx_clear(bpf_net_ctx);
>                  return NULL;
> 
> The reason this works is because they don't have to deal with
> queues(unlike the other qdiscs).
> So, ignoring the block should work just fine. Ilya, for your case, if
> you must egress, use clsact egress - the only problem is it will not
> support the more feature-rich qdiscs...

If there is no objection, we are thinking of sending something along
these lines:

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 91a24b5e0b93..2ba40eb45aad 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
  #define TCA_ACT_FLAGS_REPLACE  (1U << (TCA_ACT_FLAGS_USER_BITS + 2))
  #define TCA_ACT_FLAGS_NO_RTNL  (1U << (TCA_ACT_FLAGS_USER_BITS + 3))
  #define TCA_ACT_FLAGS_AT_INGRESS       (1U << (TCA_ACT_FLAGS_USER_BITS 
+ 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT     (1U << 
(TCA_ACT_FLAGS_USER_BITS + 5))

  /* Update lastuse only if needed, to avoid dirtying a cache line.
   * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 81d488655793..a79479faf0f8 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct 
nlattr *nla,
                 return -EINVAL;
         }

+       if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
+               NL_SET_ERR_MSG_MOD(extack,
+                               "May only attach ct to ingress or clsact");
+               return -EPERM;
+       }
+
         err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
         if (err < 0)
                 return err;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ebca4b926dcf..8c72faf3314d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
         return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
  }

+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+       return tcf_block_shared(block) || (q && !!(q->flags & 
TCQ_F_INGRESS));
+}
+
  static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
                           struct netlink_ext_ack *extack)
  {
@@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, 
struct nlmsghdr *n,
                 flags |= TCA_ACT_FLAGS_NO_RTNL;
         if (is_qdisc_ingress(parent))
                 flags |= TCA_ACT_FLAGS_AT_INGRESS;
+       if (is_ingress_or_clsact(block, q))
+               flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
         err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
                               flags, extack);
         if (err == 0) {



