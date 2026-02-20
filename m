Return-Path: <netdev+bounces-259720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iED6HuBkmGmJHgMAu9opvQ
	(envelope-from <netdev+bounces-259720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:42:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A224A167E9C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A82E8300878B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7A33B6E6;
	Fri, 20 Feb 2026 13:41:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC96346795
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594912; cv=none; b=LhKkPLjc3C5+VdzNqPQ+BkoOKIImug0vu/GDstgT5JugQriqfXAa8wvtx9fLjPmcL1mTE+S00USOPtDM0qE6RmNV0txL4zLP9tKPQkhkyyeBsXzocfu5NCbSsXy1LaUJskFTeaEETCEsrIZvZRMiIMxe0+BWOawIdKklD9lmQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594912; c=relaxed/simple;
	bh=HGBAwsnDtZvkqUfc23p+aKXmTiqOZKvezKJ2t3LESm4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sqNuG7RAhfFQVOQobYHFZ1Y+1oi9V8kfskLdKu0flZUDkzhsKrfjxl/7KGWqGWHzo6wgktEgyAQL/bwv5ISTEv6YmQDHUD8wo6ONSNSrvy91RhZk9FXes4g3efRcOtlOeu8Bq0B6Na8RLW2ORce6A9kLjG5mPj4dEEDIpxj43/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65a11e565a9so2351720a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 05:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771594908; x=1772199708;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK6b0iS21SD+l3U8eZhNhzUmpmTtRe3BakmTchxkXoQ=;
        b=rKUSrGsB351lS4paloB/a1ZXe2OnoU+zT4S7Lu6mD4O4SWmpYPnXY447bGBLs6nsF9
         62Ju31Z7GyJX7XNizKeCWuOuq23+XxWCdef4fnQ0QdMTJAzfylXObCFAZBnw+YSH9Kai
         oluPBLKuDYN51fAtH9PRXRv9c22qLq4l6UKqzyKxU75MTGMGpCGFaMeb0xLloeCKyHGJ
         acrhDueuDA+zRUv670vsv0y/3889kESKFUye3r33Ui/KoGjJ3TQqdW8vOxu/Ww4ODVCD
         HGvY26VG1t9KlKq310HRW4V+04urYv8n/7e0YgKzbyABvQo8KC6Qwc2cSvDrYEp325g9
         9eig==
X-Forwarded-Encrypted: i=1; AJvYcCXyLfXAPSz+vtscIFscZEXebmUMZpmAkGuu2/XB3M0NbPlLmm6ycXsLdfFGgdSXkE7fRvpe+5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU3v8nBEVbW1YqJ+JSra/qovqzVzNEbvsXxAOTM8gETFUzygV
	h10ru7a8woo0XqmsfahGtVfTxes5uGrVTk1AshOmyDsU+mRy0GQxjqX+
X-Gm-Gg: AZuq6aJRykGjrdyOQpszRk1h8ELhScvkdjVWkH/qd4XgewkWhNOMzQvlW6eikiDDki+
	7nW7FYP/75WXo94Fz+tux7cRWZegxa/pAwnY/mnmJEG+Tqc8B0DQWpuLvTB9YY3QnzzX1qHplx0
	i7a603JjLJL8+WO5ZfXlMCAIxmrr2Lm0+q3yFJ9amcKmJJDBbz8r2tIdMbIP3Rfm2GPx5LPrqF/
	cvUFnRi2+75HorhN6OpllQdcYYSeRzp1WheoFk3Pcvhsm+OSHJQm54sY/nGnOH+hvo22dA4jeht
	2+90iD+tLigxHoDtn7fXxIdJ5KFdmz5nF8NLuDWJOPAsoiEcxDlravGqLZWJVNPJXHDkRRtWa/4
	Lh4V8abMC6KbBtp3OqXEKM9SlYS6/5A6NTCk9XRiIp28zEMeSOjDXAei0HTcW9oMZbo1rlFum3/
	S9gJ/VedMvyy8YHcm/DYMJV6uyCYrW0sSED+7ZyoAPHkxga6QbgD2LHBeGTfo=
X-Received: by 2002:a17:907:3ea7:b0:b8e:7dcb:7f1b with SMTP id a640c23a62f3a-b903db060d1mr567237966b.21.1771594908163;
        Fri, 20 Feb 2026 05:41:48 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e579sm683499966b.9.2026.02.20.05.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 05:41:47 -0800 (PST)
Message-ID: <76d410c5-e685-43c5-980b-ecf325bf4955@ovn.org>
Date: Fri, 20 Feb 2026 14:41:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>
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
 <b4b43d1d-00bc-4168-8204-88bd9b0ba9a1@mojatatu.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <b4b43d1d-00bc-4168-8204-88bd9b0ba9a1@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	TAGGED_FROM(0.00)[bounces-259720-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]
X-Rspamd-Queue-Id: A224A167E9C
X-Rspamd-Action: no action

On 2/20/26 1:24 PM, Victor Nogueira wrote:
> On 19/02/2026 17:13, Jamal Hadi Salim wrote:
>> On Thu, Feb 19, 2026 at 9:16 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>
>>> On Wed, Feb 18, 2026 at 3:43 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
>>>>> On Wed, Feb 18, 2026 at 1:31 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>>>> On Wed, Feb 18, 2026 at 11:15 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>>  From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
>>>>>>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
>>>>>>> for the application that makes a request and for the user if they make
>>>>>>> the request manually with 'tc filter ...'.
>>>>>
>>>>>> The challenge is actions could be created as a standalone i.e "tc
>>>>>> actions add action ct..." then later bound via tc filter. Don't forget
>>>>>> actions can also be shared by multiple filters (which could be a mix
>>>>>> of egress/ingress)...
>>>>>
>>>>> Actually, looking closely at the code - this is doable. Let's see if a
>>>>> patch can be cooked.
>>>>
>>>> I discussed a bit the topic with Davide, it looks like the thing you
>>>> mentioned above could be handled. The problematic part is AFAICS the
>>>> additional indirection level added by (possibly shared) blocks. AFAICS
>>>> whatever check we do at ct_init() time, shared block could later
>>>> circumvent it - unless act_ct is always forbidden for shared blocks.
>>>>
>>>> TL;DR: I think admission check at init time can be implemented only in a
>>>> quite (too much?) restrictive way.
>>>>
>>>
>>> True - the blocks will require more surgery but seems doable. We may
>>> end up again in ->quirks() land here. I.e when an action is bound to a
>>> filter (not necessarily when created) it should check its fit in the
>>> graph and see if it is legit. But since this is only the second quirk
>>> we know of, we can simplify. Note: We already have one such check,
>>> albeit ugly-looking, with skbedit (see flag TCA_ACT_FLAGS_AT_INGRESS).
>>> I will talk to Victor and see if he can cook at minimal a preliminary
>>> patch without considering blocks, and at best one that does consider
>>> blocks.
>>
>> After discussions with Victor we concluded that blocks have no effect
>> on this specific issue.
>> Blocks are only useful in clsact(both ingress/egress) and ingress.
>> Both of these handle ACT_CONSUMED fine.
>> Code sample looks as follows:
>>
>>          case TC_ACT_STOLEN:
>>          case TC_ACT_QUEUED:
>>          case TC_ACT_TRAP:
>>                  consume_skb(skb);
>>                  fallthrough;
>>          case TC_ACT_CONSUMED:
>>                  *ret = NET_RX_SUCCESS;
>>                  bpf_net_ctx_clear(bpf_net_ctx);
>>                  return NULL;
>>
>> The reason this works is because they don't have to deal with
>> queues(unlike the other qdiscs).
>> So, ignoring the block should work just fine. Ilya, for your case, if
>> you must egress, use clsact egress - the only problem is it will not
>> support the more feature-rich qdiscs...
> 
> If there is no objection, we are thinking of sending something along
> these lines:
> 
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 91a24b5e0b93..2ba40eb45aad 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -70,6 +70,7 @@ struct tc_action {
>   #define TCA_ACT_FLAGS_REPLACE  (1U << (TCA_ACT_FLAGS_USER_BITS + 2))
>   #define TCA_ACT_FLAGS_NO_RTNL  (1U << (TCA_ACT_FLAGS_USER_BITS + 3))
>   #define TCA_ACT_FLAGS_AT_INGRESS       (1U << (TCA_ACT_FLAGS_USER_BITS 
> + 4))
> +#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT     (1U << 
> (TCA_ACT_FLAGS_USER_BITS + 5))
> 
>   /* Update lastuse only if needed, to avoid dirtying a cache line.
>    * We use a temp variable to avoid fetching jiffies twice.
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 81d488655793..a79479faf0f8 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct 
> nlattr *nla,
>                  return -EINVAL;
>          }
> 
> +       if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                               "May only attach ct to ingress or clsact");
> +               return -EPERM;

I haven't tried this change yet, but I'd say this error code should
be EOPNOTSUPP instead of EPERM, as it's not a permissions problem,
it's that we decided to not support this use case.

From the OVS side EOPNOTSUPP will be handled by ovs-vswitchd normally
with a fallback to a standard openvswitch datapath.  While EPERM, though
still handled, will cause an extra error reported to the user, which
is not desirable.

Best regards, Ilya Maximets.

> +       }
> +
>          err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
>          if (err < 0)
>                  return err;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ebca4b926dcf..8c72faf3314d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
>          return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
>   }
> 
> +static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
> +{
> +       return tcf_block_shared(block) || (q && !!(q->flags & 
> TCQ_F_INGRESS));
> +}
> +
>   static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>                            struct netlink_ext_ack *extack)
>   {
> @@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, 
> struct nlmsghdr *n,
>                  flags |= TCA_ACT_FLAGS_NO_RTNL;
>          if (is_qdisc_ingress(parent))
>                  flags |= TCA_ACT_FLAGS_AT_INGRESS;
> +       if (is_ingress_or_clsact(block, q))
> +               flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
>          err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
>                                flags, extack);
>          if (err == 0) {
> 
> 


