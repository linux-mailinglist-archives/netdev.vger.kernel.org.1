Return-Path: <netdev+bounces-230158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF0BE4B9E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E3E19C6D68
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA136CDFC;
	Thu, 16 Oct 2025 16:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4136CDE9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633857; cv=none; b=j7Fgoqf5xa/0CvU1sf72+X7WqDQdxEU7PAvgR4Tc9oqg/IomZscgMxyfuMcIwD7SkR/bp4jdZw2SxCdRGNj+UhvsokTlJ120+vfTxnlXNYQF4CqKlRJOn/Bauj0OH1Is5R7oOkk27UjyLb4X3B9ENWPMRvxv9qVGVUbEJuroiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633857; c=relaxed/simple;
	bh=fLxgIZ5eahHmXlWirJ8y3cLuljl6K3NHeKdqsr7vDqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4SoY5kOlR6R7fEAhWrNmM+1nxjuj0DMPlIWl96ROAaz28t6pSpcMPISJYBxtZdFhFrBnJ2ejimwH7/7ed9iz4b8sSs0OJJaYHXNwZ2DptMOiOK5SO0wrPlt19ObZig5bTcUCc3UMaX5oQkQnl5QPKhEGGjiuHhRk+hmC391UWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1902073a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633853; x=1761238653;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI3YZZBb+DIRLtmlprdRQzV3/BQv2YGiOUwPKfZPxb8=;
        b=Rqs73ghjtQ2AxNPF/IyNHHzMIswHpKyGj7jWMrJv0wSx4gurIwvtjZ/DXJJiiiEcAf
         ih86+yHcVqJfQ6dEdli5hcmCpZvrwaWIifnC8mrGV94BW2zcQ0Bf6i1/fyhPqis9yRPX
         mnLxIbmJOxqPXhAz8vp1avQtu+ROoOK6pGkl3f9b89Xu4567Ya60EArdCm4F9KSJVEem
         Bd4igC8sdT1Wi2KAnXlrYxSVxUgjynL5EN/35TdiIIXeks8BIygu4NeEQJwXFR3Ecc2T
         7wkgb4rAoRin7T+CwsCUBv17ftXFe+s6EsxJip/9ZQGhLL77oVo9s6DYqZ/qSeuygnJB
         ZQ3g==
X-Gm-Message-State: AOJu0YzgNG4DM5wLUtZDpSUh7Gd5dVNnGS2K6DYdjY9XunQI5gN1iHMH
	ft39Hn32QgFyXiJNZO44I6e+1Qj37XzTP6ye+fNdglaeULyXj/3+oVY/aP7/a55Z
X-Gm-Gg: ASbGncu2f0soDDdvbFIe3y+4tYdndtrjWkcmxwU7EKF5obBzcv2B5YeGMS1SmtSWnO/
	ZbTwm5d3Ti4hMoY4uv+L0EiG651WdJ8g5SZLtOtDOS+SnH+H8EZ53Kg3oDWbEbYYMmY2MIjGPdy
	H/HpmF/Bsm3pmJInL72PnZ+qbaon5DQseNmmdElCQG189cTa3L4kgrhdOP5cyAO1dEVFJIDj1DQ
	/jgS1vwsbqMAabLSkndgbOwlUFRbGns3/YnYh6LPBDooxCuz41/HOvEIHwo9h3mnynyC4CpyCvu
	z2UkdD4AmVxooSFVDuFmpWYpcggfhZMZfzEd36bVYF0Yf39ZmgEHCvvlIpp6L3htfW5Hk3mIrEq
	GpFl5fsRNbA6ii3FlvrTVPjhIQNqaBI7krF5x2zFdnXpIVlNhZxg5CcrjIVEaM0eU8gQ0ms3UDR
	TcM5cqL5Kru387BW88OOnPuqolvCCPpyvD
X-Google-Smtp-Source: AGHT+IESEhILdkTDLvEn0SW02CEGrl7LIGNd/Z8bfWyRCcerfJd/YqzwOlr4wJ4wP0kUnpmRzLmVVw==
X-Received: by 2002:a17:907:6e8d:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b6475706246mr72308366b.58.1760633853232;
        Thu, 16 Oct 2025 09:57:33 -0700 (PDT)
Received: from [192.168.88.248] (37-48-48-237.nat.epc.tmcz.cz. [37.48.48.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5fd784022dsm422841466b.14.2025.10.16.09.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 09:57:32 -0700 (PDT)
Message-ID: <fe1c04ba-3964-4293-b2d2-667fdbdc8f8a@ovn.org>
Date: Thu, 16 Oct 2025 18:57:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build commit for Patchwork?
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>, i.maximets@ovn.org,
 Simon Horman <horms@kernel.org>
References: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
 <aPEcgcsqFJAEYD_2@horms.kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <aPEcgcsqFJAEYD_2@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 6:25 PM, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 09:07:09AM -0700, John Ousterhout wrote:
>> Is there a way to tell which commit Patchwork uses for its builds?
>>
>> Patchwork builds are generating this error:
>>
>> ‘struct flowi_common’ has no member named ‘flowic_tos’; did you mean
>> ‘flowic_oif’?
>>
>> (https://netdev.bots.linux.dev/static/nipa/1012035/14269094/build_32bit/stderr)
>>
>> but the member flowic_tos seems to be present in all recent commits
>> that I can find.
> 
> Hi John,
> 
> I'm not sure that it's explicitly exposed.
> But if you look at one of the builds for the 1st patch of the series
> then it will start with a baseline build (that is, build of the
> tree the patch-set is applied on top of).
> 
> In this case, looking at the URL below, which is linked from
> the first patch in the series in Patchwork, I see.
> 
> cb85ca4c0a34 ("Merge branch 'net-airoha-npu-introduce-support-for-airoha-7583-npu'")
> 
> https://netdev.bots.linux.dev/static/nipa/1012035/14269097/build_32bit/stdout

My understanding is that it just builds on the tip of net-next/main
whatever it is at the moment the build starts.

FWIW, the field was renamed on net-next at the end of August:
  https://lore.kernel.org/netdev/29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com/

Best regards, Ilya Maximets.

