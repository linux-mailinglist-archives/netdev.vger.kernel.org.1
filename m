Return-Path: <netdev+bounces-102536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4A9039BE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A2286B77
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281717997D;
	Tue, 11 Jun 2024 11:12:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8446525;
	Tue, 11 Jun 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104362; cv=none; b=nsohSUkRmlEYNQHd8bq2WQolGJLFY3fPGi6VXqDqLvddQ8gwnOgBGqDLdxWTss6CX9TyRU5ANlQN6BXx5wdeVxUBv25KElyyETFJe6JjeCYDltqU86TPs9brMaXgE8W2s6+Tuse012UxZYTqNLN4zODQ02F1RvoUjN2NA1KNi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104362; c=relaxed/simple;
	bh=dM+EXUA5AbY5Jw21+Uo1GoXzFfpTC61FcZV7rNbvwu8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=gXzcsGm7czCgVn1YhEWIvZwCH0Lhs0GgKyOfxxX5C8LOB3TK2IQz8EQfHFcSy9O1TZi1b0+0oAs/4q0NIuXP1ch3AuVHJGkzdmHBaoWXSnsfZ7Y5NYg4TIGwi1wjEfqZxLedX3DLfJiC6OEZGKElq/BYg3NEKNsnuUmDtJMqvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzQT-00HRNh-JZ; Tue, 11 Jun 2024 13:12:29 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzQS-008yqG-Kl; Tue, 11 Jun 2024 13:12:28 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 42D04240053;
	Tue, 11 Jun 2024 13:12:28 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BB964240050;
	Tue, 11 Jun 2024 13:12:27 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 54A6F29768;
	Tue, 11 Jun 2024 13:12:27 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jun 2024 13:12:27 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/13] dt-bindings: net: dsa: lantiq_gswip: Add
 missing phy-mode and fixed-link
Organization: TDT AG
In-Reply-To: <20240610220531.GA3144440-robh@kernel.org>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-2-ms@dev.tdt.de>
 <ae996754-c7b9-4c46-a3dd-438ab35d6c67@kernel.org>
 <c410ac7cce5fe6bf522bac6edb18440d@dev.tdt.de>
 <20240610220531.GA3144440-robh@kernel.org>
Message-ID: <dbd7b98007dc0bd9f8fbf2160d8fb8ed@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1718104349-37115522-B45A8A00/0/0
X-purgate-type: clean

On 2024-06-11 00:05, Rob Herring wrote:
> On Mon, Jun 10, 2024 at 11:07:15AM +0200, Martin Schiller wrote:
>> On 2024-06-10 10:55, Krzysztof Kozlowski wrote:
>> > On 06/06/2024 10:52, Martin Schiller wrote:
>> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> > >
>> > > The CPU port has to specify a phy-mode and either a phy or a
>> > > fixed-link.
>> > > Since GSWIP is connected using a SoC internal protocol there's no PHY
>> > > involved. Add phy-mode = "internal" and a fixed-link to describe the
>> > > communication between the PMAC (Ethernet controller) and GSWIP switch.
>> >
>> > You did nothing in the binding to describe them. You only extended
>> > example, which does not really matter if there is DTS with it.
>> >
>> > Best regards,
>> > Krzysztof
>> 
>> OK, so I'll update subject and commit message to signal that we only
>> update the example code.
> 
> Either convert it or leave it alone. If you are worried about users' 
> DTs
> being wrong due to copying a bad example, then you should care enough 
> to
> do the conversion. Given the errors we find in examples, it's likely
> not the only problem.
> 
> Rob

Then I will convert the bindings to the new YAML format and send another
update of this patch-set.

Thanks,
Martin

