Return-Path: <netdev+bounces-282910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MDSBWR382mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D394A4EA0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02030302B23A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C231D381;
	Thu, 30 Apr 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="S7Tb+4iQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235153148D0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563437; cv=pass; b=OHPS3o+TF1FaIzbzRlFAaSHYVK2JbJ0PAYFZO8LQi9sSyvd64moUqA9mrtDco+uCfB20LizxdkOILuSs9zBhvABNTgSGoK6A4Y0+n/mtYtcz7KCq6OKi6HdmsO5VmBfKIv/+A3zagDjjDNxAPLYz7LmcVZfdiXGeOrT3d1J+fzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563437; c=relaxed/simple;
	bh=4rAAaw2u+l5+w139S4C9brgw1IKGMDn9USBUvCJgE1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejTSGxFeLeev5/8nQvZPxDV/GpbGVOvOlL+IHwhoYYe98ik1iyingaqefI+30OorglZeLDfk8z+VQrI6T6nSX7zSHkpUVk8ygnaHnV7XASQlYRiUB5cQKcEWJbF0CDo07q5HjczQW3SeV/zVBUPeKVosfdvMFAvacr3pANxSe+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=S7Tb+4iQ; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a60975dc5so13276057b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563435; cv=none;
        d=google.com; s=arc-20240605;
        b=UifpJ6wFz3QGZrHETISvgwuuHtmFqndVSXJWfeg7CIykod7MpElid6qnzXu8LMnn0J
         V9ZtT12SR6KT2blE5gDJgMqk5EeOR6cOJWDvOODFgEfiNU8Ls2nds20GyrqAFCVmr88W
         NUIFZc+kw/Ab3PEpPhhkMhIIfS7AbgjNkWAEL5twbdBf9sUTEji8Vak+n7AC+0e6WZTJ
         skBw11mR7Uc/jPtFqBMDf7DBuRJGnFmuCyQaqJZV0Cy0cIG1dg/Fwb7LibiMFyJtXaKU
         8aLVXjj7i/oYuxSiiKe+0wv1sXYCFua82ZwyrOFdVAl4F/oi+NruG82VUENnFtT7JYrl
         WDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rAAaw2u+l5+w139S4C9brgw1IKGMDn9USBUvCJgE1g=;
        fh=+0toPGPcfL48ts5Kb9jgJAL3IUYjIoDCg/KvzccWGKo=;
        b=EZJ6A+dyjprJ2M0zUbN7xyaTV5QamUQngm3XHOeGVkoy0M3Ys22pFuA23fAXiDAfQH
         jtheSZylY4twmYsrPoOwHZAqWZXPWccFXLzQY71LmjxlQb5JkXmXm5j7u/SO8+FQpVxB
         oj1NPowPzmXiByOsToy+rm8aJwrooemaP7W8KI1XF1mCZ3iV/4oTVaXkrJiZIWjx/FfJ
         PSk3ZHghsMvPoPc9223ZNhTk0jgQ04yFdARYTlCp5/IPGUXJt953S8iF1DulNiMZEHcV
         qqbfWA3mBXExaF9hQnrmWbuWHHNYVcmhIE+EenZ7a0/yIww6MqGG9l2tekBUfk4CJpni
         300Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563435; x=1778168235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rAAaw2u+l5+w139S4C9brgw1IKGMDn9USBUvCJgE1g=;
        b=S7Tb+4iQbfwaVtk1P2LlAVrhmRs7Ev6+2IONV1Pcr5ND2d9X8TLMt3JimUrx2PKy6z
         0T4hR9kzdca+AQb1ZjD8gR10IJn0Oui3gPq89cpL9o33DWIRZMiN8ipMjh6Op/lmijBe
         LrDWg2qR9IL0UDTuRFAe+jNp8Mm0nEly7TQj1fVwtei+foT8cwjSjl/a1ZHWNbal3zoi
         MvzUdZ+eeeWYhDErWk7VN3svWBi0jvl5W8EleeUH6HqItLECBQ/qg5ndn5QeLEkRnh5n
         /8ULA94LBM+slnZVx8L315ZLIMHCTZ53klFS9ic1rhItzFXKPIvWp5c0hTJHyBgEdY7z
         enMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563435; x=1778168235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rAAaw2u+l5+w139S4C9brgw1IKGMDn9USBUvCJgE1g=;
        b=ikdfhHwUn4dvKkaa/bjCD8xWUZJFzRWAuAX50NBbTd3PP4k6UXsgMCxpTub2ncyYf4
         YrcXaJ0TSsFFCHlolHldxBfrYf/LtSMC3/s7DT1c179Jbqd+x1R2rP4swpYUVhovdHcF
         a3hWua2Rcz7EwLIPYzIbFE5JWWbkBrcRUZ2zE8LrLWHsV22giVqT7Mcz/cz1qHdBoAgY
         HCfHuiYRDRmOwNyVj5im4oPl871sQwpjmJTU3NlLLn8EM8ZTKGo4GI5ZVEE1LAT40uPL
         bhRWUXVgvi9NhoXUocr8+uXcAyU8wtaje9JrYZoRw4EjrI6BddTHuLw7gHrMQIfNkwjL
         XM0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9O8amnQ+0zuBzk2sSKUy7Nx4+/iexpgnBEdgD4tLr7N/yPMQ0dXtKPZ6AnUUTyO1d3ifj/aVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpHnouprGbdheCubQJA8soBAwUHrTGkv3hHLqsNfZSlaka5IP
	UQSE+p9IIQ6Clu6X0KILQCNunzoJLtNlR9genKAFaUrZluec9ivvlMOcViDNwGqOEYqPoRXxcJg
	wCUfekslA/1NtM7l1InPkXJr3+mSAdyRIym8eQh75
X-Gm-Gg: AeBDieuKkx0e8uTGJ0R8lK7UIJ0S4LGI92qPYjxg4xaHlYkD7knu7Nqz+ZM4Cq/Ni0H
	M7cAdIlSvLCT/JClgbtJ2EiHe6BFFy/6FcOcbpaZaua1C5wvwK71u8dsOREmTL+HjVjgLeohyfq
	PY6gxJRCsT/kIkkMUGNLw/nXnit1kWSm7CJ2NoKG/lT3lWDzKEht9cFA8kmgV6oqyr9ts3554a0
	92TnzQ2LA6Bx6qFMfA/MmiKk0h5waxIiIgt4P49aTS859VUC7z5Vs6VacBgjSV+fM0yrLMNbCAM
	I8lcqzCwrcKAPsGzXrx6Fqz/DLDsqw==
X-Received: by 2002:a05:690c:6609:b0:7ba:eefe:9fa1 with SMTP id
 00721157ae682-7bd528247acmr36850857b3.6.1777563435175; Thu, 30 Apr 2026
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428145730.26375-1-ghandatmanas@gmail.com> <20260429185248.4761905d@kernel.org>
In-Reply-To: <20260429185248.4761905d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Apr 2026 11:37:03 -0400
X-Gm-Features: AVHnY4LwOLVm6sSLOF8RDa500TEP6ehCzzJF3ZHxq6fpB0QAlSfcQE_yEsha5P4
Message-ID: <CAM0EoMms0LHVCRSPe0t6QPgCPOnbWMVSp8TAws45i2GLxR6JOA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_dualpi2: Add missing skb check
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manas <ghandatmanas@gmail.com>, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	rakshitawasthi17@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82D394A4EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 9:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Apr 2026 20:27:30 +0530 Manas wrote:
> > A packed is dequeued using the function `dequeue_packet()` but there is
> > no check to see if a packet is dequeued. The assignment is always
> > considered as true resulting in null-ptr-deref
> >
> > Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> > Reported-by: Manas <ghandatmanas@gmail.com>
> > Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
> > Signed-off-by: Manas <ghandatmanas@gmail.com>
>
> Sorry but the patch is nonsensical. Please don't waste our time.
>

Fixed in: https://lore.kernel.org/netdev/20260430152957.194015-1-jhs@mojata=
tu.com/T/#mfe773e91a05e103f47dfa71ea434210aebb74e17

As I have mentioned a few times, when you find issues, please either
a) describe how you found the issue (a reproducer helps) or b) provide
tdc test case for extra bonus.
As you can see the issue has _nothing_ to do with dualpi2.

cheers,
jamal

