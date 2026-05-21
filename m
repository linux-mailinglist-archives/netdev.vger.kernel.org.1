Return-Path: <netdev+bounces-290556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG4GFYhED2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F15AA785
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A6B3315E59D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A837107E;
	Thu, 21 May 2026 16:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319D36F8E5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379306; cv=none; b=gCDpCMxQB1eC5jhHQg7AuUVl04txowb9qbNoTIlEW2LJysVtu/642q/Qt74eAjvRqlwBJDKIhwJHq1c3UFc5EwJZqukt7D1iPBpffBg0p1aQESSYz7nyxJwYVmvqrouFH1SyApI7HDK9GojVxivhvalreugJmF9YQjJbIBgd+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379306; c=relaxed/simple;
	bh=4zM1ugNCLmNapDX1aXtA0pmcHFvT7iOMdAhWydF0hF8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CrDexUW4FD1aQuLwFvHqeNBi9YAlWOx2Px1zzRZEcqeeluZTeHYQIVLgJstsjtiZnsCZPLnML4MvLjTQ8hBudHqvSynoL1E1MjA7XqVkJeGucHN5GV7lJui7eqJrrN+ZYznAhzCOMbsvbUKsVifr8ko1BFBktAyRmZES8vBXMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48e82c23840so51433845e9.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379303; x=1779984103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb7NHOCqWYUK919ibqoR4LSTe+C7bYY+lOLvabZfEs8=;
        b=jA+DnR73PDxUkOfoOfo7pmHNZA6Jbwa5Bfpk/Z4kKhGJJ1cRC6pZr8Czfdv/MTpDJP
         n8Enz4sG1YVgmzDfyK4mbjMYcLjYV/vQTtMquKnQn3THcOvvGKiOXYKgHpu4MU7K9KjE
         PHuOLIjXntyFO4GoikvA+fOXUkUk5hX+srw64ONo6AH6u+dTFqgDCnlVmT+q5lDc5kM5
         R3xjTJOvyBFnz9tDqdF+KfNM3MVFkdIRyPiMMeUQc3lsSi85FV/bWw+6rthUsC9b5gFb
         H3ks9FhQ3ysxlk63q/JG704vyUADYUPNK2pPtfhOdIBdynFEtCCPPBtz0d1lZ77xNK4C
         pQGw==
X-Forwarded-Encrypted: i=1; AFNElJ+hCPJ9s5I8LJZrWQGDwAf22kUSdI3X5X88n+fcI5son9tLC09p50Ix4KUNSTnpKfcm7tVDi+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqQX4HDHjPkVuPL9C4NcbxpYZ4Lgr5BBPfSLdkALaZgDqGtjD
	RlsLZfqeBw2r5HyG8RWyr78E4pH1V+fbZkxXikaEkrfhrk9f9m+udReS
X-Gm-Gg: Acq92OGfIYcJVcMI6RQz99t2kw9rdfxcATPzcuHo2gOrw7GgPnjfT4xpKSyaJWt22iB
	vt6eujnHRrMGXcuQromoQhqCJKDWWwaAbIH5z2dIPRZ7Qbpvy5Z+0ssca76ckWzXRgxeiCqsBfo
	JgFeHL2TIg0dVHRau/6hjEbWqVKs/Vz/Y/Iw/QXWk20EhF6WQ43A9AIcjTePgpDIlamkc0GrLVn
	NdBUJzxGlOzJoffjtxtGfsvqPr/FrydFV4x5AGgLsLPZofT/XuWo+iRCA7qPSEB6pJEsg4PzKDG
	Yr4zXe26E4L9TGzxHopJhMNbrtyDSMaBQssyvOxfJ6rtFQOU/ay/ca/QzQNY36YmD5FudRzdZC8
	Ymh+S8JcFCyXhxNaJo227yGvCtvTwSyeT7fR8AZXwmNEXf4Wvckx3z4ZdJyarvyteX/zaCCEORf
	CkI8ym8pGyrcrdSIRXU0AVlkxuuBE/UTTw7k6x+wThOpk7tJ728AW0eWc84lhUDuWa1tT/FXOp6
	usJ
X-Received: by 2002:a05:600c:4818:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-490360bac01mr35583275e9.22.1779379302644;
        Thu, 21 May 2026 09:01:42 -0700 (PDT)
Received: from [192.168.88.241] (89-24-33-222.nat.epc.tmcz.cz. [89.24.33.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033cdcc01sm82691195e9.0.2026.05.21.09.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 09:01:42 -0700 (PDT)
Message-ID: <b8183167-9e8d-4c75-b340-bc3437a14ea0@ovn.org>
Date: Thu, 21 May 2026 18:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Kees Cook <kees@kernel.org>, Adrian Moreno <amorenoz@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
To: nicolas.dichtel@6wind.com, Jiri Benc <jbenc@redhat.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-3-i.maximets@ovn.org>
 <bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
 <20260521160036.413771e9@griffin>
 <9e7b7aab-dad4-4b72-87cd-822e67b27afe@6wind.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <9e7b7aab-dad4-4b72-87cd-822e67b27afe@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-290556-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ovn.org:mid]
X-Rspamd-Queue-Id: 6F5F15AA785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 4:25 PM, Nicolas Dichtel wrote:
> Le 21/05/2026 à 16:00, Jiri Benc a écrit :
>> On Thu, 21 May 2026 14:36:12 +0200, Nicolas Dichtel wrote:
>>> I still don't think that this is the right "fix". The app is broken. Even after
>>> this patch, the bug could be easily triggered again by a third party.
>>> There is nothing wrong with assigning a self-nsid. It would be a lot more robust
>>> for the app to assign itself a self-nsid when it starts.
>>
>> On the other hand, does the patch break anything in practice (as
>> opposed to in theory)? It makes live of several apps simpler, which is
>> not a bad goal.
> I'm not against the patch, it just look like a workaround.
> I'm trying to understand how NETLINK_LISTEN_ALL_NSID is used (in fact, why it is
> used if the app doesn't "understand" NSIDs).

ovs-vswitchd works with NSIDs of remote ports.  So it does understand them, it
just doesn't expect the self-referential ones for the local namespace.

openvswitch module has a minimal support for cross-namespace operation.  Ports can
be added to the openvswitch datapath and then moved to a different namespace (it's
a little weird use case, but that's beyond the point here).  ovs-vswitchd learns
new NSIDs of those ports from the openvswitch module and then it can perform a
limited set of cross-namespace operations on them and monitor their status changes
through notifications on an all-nsid socket.  It never learns the NSID of the
current local namespace, because all the local ports can be directly accessed and
openvswitch module doesn't report an NSID for them, as it's not needed for anything.

In the end, ovs-vswitchd knows all the remote NSIDs it needs to know and can
recognize them in notifications.  But it doesn't know the NSID of it's own local
namespace, as the openvswitch module never reports that for local ports and
ovs-vswitchd doesn't explicitly check its own NSID.  So, local notifications with
NSID set get treatment of a notification from some remote namespace that we do not
care about.

We will be putting changes into ovs-vswitch to work around this issue, simply
because it will take time for the kernel patch to propagate to distros.  But this
code will not be useful for anything except for working around this one specific
case and so it would be nice to get rid of it eventually.  And it would be nice
if future applications didn't need to care about this behavior as well.  Having
the fix in stable will speed up the process significantly.

HTH,
Best regards, Ilya Maximets.

