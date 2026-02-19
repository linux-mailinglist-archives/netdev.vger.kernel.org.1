Return-Path: <netdev+bounces-259440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC4lKyn4lmn4swIAu9opvQ
	(envelope-from <netdev+bounces-259440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:46:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B815E674
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7625A3003BEE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862D72FE04E;
	Thu, 19 Feb 2026 11:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C823EAB3
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501605; cv=none; b=Ll2ZaR0r0PkRI0EYx5MTXv29qqUSuBFE7joaxaYE7uURMtny64rRYnmtmU59bV9AXRE0GpECLBCgmM0I3QR3iWljum/ML20ryby9S0f/pAdb1cN71zhrQ3HxQqf0F9YND+NPDTFoMrQPNExEyl+Kw8Cy2MppNWX91BR6m/PBqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501605; c=relaxed/simple;
	bh=g29daOS9W3mgt2UdZnY8EGuFtI9tz0u8Ms4qQKin1QQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fodgt4SgIWIaHdKxE19t5wuRa/g8jy4iTIK9spmYQ8y4s4XdWi0pHQR8dPMPaKnD8e3kQtWO0tfazlPhQQBrZ7wXJ8fNPfwN0Tma7NgBdgpqVnA+8SVflK6VzU5sZftsqUDvViwRQ6tKEU8kdD5IqkhWUxOo8//IEC049GOX6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483770e0b25so8841685e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 03:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771501602; x=1772106402;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOyxwznXWupzLXLk0t+GG+eowai8a0ZbUkKprGqJylQ=;
        b=po3VOM8/uTVJtI8bzFxJ42FKg3m+lxInfdswf+QAR46gI5ML6ftyTnmOsb9I8NbZ+D
         Xng9SSh4vPvxVIYx413/Araj3hLORsextmi4rDKi9A85Hv2JwPjVUNbHdZ3SkH24DWJY
         27F17+DGZ3BbrdCCHAL6iwYuGYzc0CoKiyGUdIm+ooQPg4AK1ycazeg79wePu5I+bL6S
         hO+XNdAa6ZIFs66bzBhPYY6S/7+tQDh98Wl9AxfH5hWJHVdtQMtzUc9wVEZqCSZ0YfGN
         tnXk6VI1vFfLYrP1BcwDDbyHDGbm2/J93WeYFwk7nF8pYMZM0DW++7MfO8nuHtSaVwXD
         tpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXTT3lrcF57pNcDHmYrvrOViXYcWYiNZUV8UZVwRiDF58yNXPK8oxL2Odgmd7joTqiN1vVKHVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+VmBRmZ/x01DYkhUFw91RUW1aY6q1pWC1o3Xdkuht/lYxSuN
	+0Ow9OB72gVRYyzasMlIRkOLJEHOIZmC4IsaM2H9wEJPPc67519lnIzx
X-Gm-Gg: AZuq6aJGPgzOjlQAo0LAXBIc+IRA/R1Q4LwqVDIx1ePZY1u3X/5ULbsB3iPmAe1rgOG
	KpIh7seqoLYiAe/2+TD3nsVEPkoGEymfKuKWq/4QFeieREtZI3djrdIzITY+nJqduyiu71N9VLh
	b7wNBrr0ceKKUEFVTmukos6KDEBBv9O2M8NnbVVE1t2lSjcWEhsr9QWEmzwz49/FYAgmNWJGJzF
	yliEAy9EYBk7zFLPeKXSAauy39hqVb0OcKBYooJqDBUKPtmvGuV1YKgLyhXnjPA0Q77bcNtpu17
	8nYyK/A6bsea8LoiU7E6W0NrObAPOBwJptC11H1uQ2Dij95r1cpOPV6ebhEC2CBKywX4SAiypDg
	qA0O5G2dfsn/783RCJJ9HfreE8vvOSsbeMcAqFSOo0rGuuhSI9ORZG9oBJnOr08WG5sxkYBt+YJ
	BGLOwYj+QT2zsLAbc88xaRqDbl83PbZ6KfvRLdk/22LYCWCWsgX0IrFwbFBvWXRpu5zUCspQ==
X-Received: by 2002:a05:600c:474e:b0:479:3a86:dc1f with SMTP id 5b1f17b1804b1-4837109740amr369539025e9.37.1771501601797;
        Thu, 19 Feb 2026 03:46:41 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm1150543685e9.11.2026.02.19.03.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 03:46:41 -0800 (PST)
Message-ID: <09aa06ab-765b-4cc9-b450-e7bb50192c44@ovn.org>
Date: Thu, 19 Feb 2026 12:46:39 +0100
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
To: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
 <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
 <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org>
 <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
 <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	TAGGED_FROM(0.00)[bounces-259440-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: D67B815E674
X-Rspamd-Action: no action

On 2/18/26 9:43 PM, Paolo Abeni wrote:
> On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
>> On Wed, Feb 18, 2026 at 1:31 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>> On Wed, Feb 18, 2026 at 11:15 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>> From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
>>>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
>>>> for the application that makes a request and for the user if they make
>>>> the request manually with 'tc filter ...'.
>>
>>> The challenge is actions could be created as a standalone i.e "tc
>>> actions add action ct..." then later bound via tc filter. Don't forget
>>> actions can also be shared by multiple filters (which could be a mix
>>> of egress/ingress)...
>>
>> Actually, looking closely at the code - this is doable. Let's see if a
>> patch can be cooked.
> 
> I discussed a bit the topic with Davide, it looks like the thing you
> mentioned above could be handled. The problematic part is AFAICS the
> additional indirection level added by (possibly shared) blocks. AFAICS
> whatever check we do at ct_init() time, shared block could later
> circumvent it - unless act_ct is always forbidden for shared blocks.

I'm obviously biased here, but if it's not possible to cover all the
cases, I'd still prefer a partial solution over the no solution.
If we can handle just the RTM_NEWTFILTER case, that will allow us to
at least avoid breaking a known use case with OVS.  If it will be
possible to circumvent that with block sharing, then we can still drop
fragmented traffic there.  I'm not sure how widely sharing is used.

Best regards, Ilya Maximets.

> 
> TL;DR: I think admission check at init time can be implemented only in a
> quite (too much?) restrictive way.
> 
> /P
> 


