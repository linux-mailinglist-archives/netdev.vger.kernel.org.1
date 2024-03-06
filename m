Return-Path: <netdev+bounces-77785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0B87302C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C754B287DF0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBC5D470;
	Wed,  6 Mar 2024 08:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152305C057
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712233; cv=none; b=SNV+/mJT873FZSY+ACDImypZEpTLMolE6nJpBuYwLdrxfr8n5QtTVKPkPXlqBN6AH5Z21u7kuqGxXE76KYhZnzwJlti4RHR+p82340nJVfHVUrSNDrDH0Av/+dbb6CVtW9rRXTdS/fc7+9SYFFC890a0TszEH4Osc/x5zakOjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712233; c=relaxed/simple;
	bh=IXhbopC1Bk+7Fc83Ih3rvnZjSieTDFD/HP+fm5h8z6A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g/sHy5Z8EAF3szDnc7cnmnfhYumJMHcbatJkpdIB2EkZ76P5a7WG6UVLWCH052hrsSxcFAqWL/B52N6fdA8lALo0x3tPBf1Yh9kHvuMSof3sqJVr37ylneTOSzWF0EQGo6b1Kp5undU2d001uwGCKHLU3jk424ucpeYpZhME364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from mail.rmail.be (domotica.rmail.be [10.238.9.4])
	by mail.rmail.be (Postfix) with ESMTP id 017484C83F;
	Wed,  6 Mar 2024 09:03:44 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Mar 2024 09:03:44 +0100
From: Maarten <maarten@rmail.be>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
In-Reply-To: <20240305130728.5d879a7e@kernel.org>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
 <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
 <20240305071321.4f522fe8@kernel.org>
 <45ba80640e989541e142c32fb3520589@rmail.be>
 <20240305130728.5d879a7e@kernel.org>
Message-ID: <42cc2d7ec8913a3a71e918e3f116c55e@rmail.be>
X-Sender: maarten@rmail.be
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Jakub Kicinski schreef op 2024-03-05 22:07:
> On Tue, 05 Mar 2024 21:36:03 +0100 Maarten wrote:
>> > The patch has minor formatting issues (using spaces to indent).
>> > Once you've gain sufficient confidence that it doesn't cause issues -
>> > please mend that and repost.
>> 
>> I'm sorry, it was blatantly obvious and I missed it :-( . I had added
>> indent-with-non-tab to git core.whitespace , but it seems to only 
>> error
>> when a full 8 spaces are present in indentation. By any chance, is 
>> there
>> something to test this? In the main time, I'll do a git show -p --raw 
>> |
>> hexdump -C to check this .
>> 
>> I've fixed that on my git (and fixed some similar issues in other
>> patches) and will resend.
> 
> I'd rather you waited with the resend until Doug or Florian confirms
> the change is okay. No point having the patch rot in patchwork until
> then.

Ok, hopefully it won't take too long for them to do their due diligence.

