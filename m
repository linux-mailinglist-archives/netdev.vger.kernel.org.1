Return-Path: <netdev+bounces-110572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAB92D2F9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE7AB226F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF61922FE;
	Wed, 10 Jul 2024 13:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB491DDC5;
	Wed, 10 Jul 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618800; cv=none; b=MLaBdMgbFVAj2xic3J9AqtgtrXoI5lBwL/IqvUGa/XZbMyD4ldOCadbL8pWpdjc/KORcIBbOUO1a1ZDya8q/zWn3JmAoxv45Vwq9OfaJ+OY07EPdmm/CoqNOleo2JF4r/lKVguAhDRHaNNdfNzxIFkDKM13Wo1oaR23DyilBoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618800; c=relaxed/simple;
	bh=zDyx6B8RGymWfBCosR9zXsoz0W7HJYiHuVuHXLWVBB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wj4oS979Fk7W9tuVIYt47mYP3mKNgAqcY0v9yk+Kt0RPARkDvEjqBVp37w+pnz++53h3GXmdR29kB2vTSmHw/IBe7XSu56c5y/p3BHzCNGegBGeNBj41dwkFKa4trNj3D7KuZC/N7q93w5YG16y9yTTADzBPM8KOY/jNFHtpNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=10572 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sRXS2-0005lu-EZ;
	Wed, 10 Jul 2024 16:33:42 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1sRXS2-0056Eo-1L;
	Wed, 10 Jul 2024 16:33:42 +0300
Message-ID: <c5601e9d-e020-483f-a984-886f1aaf3207@ancud.ru>
Date: Wed, 10 Jul 2024 16:33:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] tg3: Remove residual error handling in
 tg3_suspend
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Michael Chan <michael.chan@broadcom.com>
References: <20240709165410.11507-1-kiryushin@ancud.ru>
 <CALs4sv20_K0P_Ach=_kZ1jDZHKXvvcNBxatF9sP0iHRNku2OMQ@mail.gmail.com>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <CALs4sv20_K0P_Ach=_kZ1jDZHKXvvcNBxatF9sP0iHRNku2OMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Right. Last time it was applied to a wrong tree (net instead of net-next) and then
reverted because of this. As I understand, it was meant to be re-applied to net-next (https://lore.kernel.org/lkml/4726fefd2a710cbee0d1a7fb15e361564915e955.camel@redhat.com/),
but it seemed to get lost in process, so I decided to resubmit.

On 7/10/24 07:53, Pavan Chebbi wrote:
> I am not sure I understand this patch, commit d72b735712e65, which is
> the same patch, is already applied, right?


