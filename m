Return-Path: <netdev+bounces-17047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638874FE9B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 07:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD271281682
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF944644;
	Wed, 12 Jul 2023 05:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235F1C2F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:10:17 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48E1989
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689138600; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SpoCVInNA3Jppapcw4lFzPA4zjLczR8k/VhZOAUfY/2i9i6sdbx7vNP302wqHYbjFjeNMNuq8cR1j5dTOdvykjKAqQgrEIz1mG7QwA3Canbqg58EFwkFsylttIe1f5N3VU89rISu1CxJu+5sovQkO/2C9cn4SsOk7YWcrWEpg+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1689138600; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=F/DeEoVoc0cNDW5+tJ5hqWU4NMH63S3DSr2k3QR8BZY=; 
	b=jv7WxIkDyEtWVZD1FKEpZLFSoax8kopd4SdJItmd/z6Z4bHVvN2KhJicsxY6Kg/01OHZXjapQCeApNplkBw+c4zAMOQSj7GmvTzY8Y6cUBWQ8HbRDg+fgaScAfOxwklmlSFCqXTK2t0t+bIaOz7bciEPxqg6ImTEwjdiD2t5up8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=chandergovind.org;
	spf=pass  smtp.mailfrom=mail@chandergovind.org;
	dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689138600;
	s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=F/DeEoVoc0cNDW5+tJ5hqWU4NMH63S3DSr2k3QR8BZY=;
	b=X5n7UNNA6A52Ni+WrbtgIfTgLwHxryhW259NEMB6dBOdJqSA7T87QHouNm99Qv3u
	WSj3T0WS2GEIXjwy7Tm9MaiNloR10RbKUTjfDwCervIKtoC/dULOrEeOpzafS0Hvdji
	+EBD4Y7OPD/n8ZprzrjOUBdPIZCdDQrwFExcm0F8=
Received: from [192.168.1.43] (101.0.62.3 [101.0.62.3]) by mx.zohomail.com
	with SMTPS id 1689138599020849.8587474068147; Tue, 11 Jul 2023 22:09:59 -0700 (PDT)
Message-ID: <88be2564-c5cf-58f5-b35c-d61e1db504de@chandergovind.org>
Date: Wed, 12 Jul 2023 10:39:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH iproute2] misc/ifstat: ignore json_output when run using
 "-d"
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <2d76c788-4957-b0eb-bd5f-40ea2d497962@chandergovind.org>
 <20230711133040.2fef3caf@hermes.local>
From: Chander Govindarajan <mail@chandergovind.org>
In-Reply-To: <20230711133040.2fef3caf@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

So, this does solve the problem correctly, in the sense:
1. First you should start ifstat in daemon mode (without -j, with the 
patch, it will anyway be ignored)
2. Then, you can run ifstat in normal or in json mode; where it will 
connect to the daemon, get back results and then print it in the 
required format (table or json).

So, this patch only ensures that the communication between the daemon 
and other instances happen correctly (not in json).

PS: in the process of testing this, I figured out a bug in the -j mode, 
I will submit a separate patch. :-)

Regards,
Chander

On 7/12/23 02:00, Stephen Hemminger wrote:
> On Mon, 10 Jul 2023 16:15:22 +0530
> Chander Govindarajan <mail@chandergovind.org> wrote:
> 
>> If ifstat is run with a command like:
>> ifstat -d 5 -j
>>
>> subsequent commands (with or without the "-j" flag) fail with:
>> Aborted (core dumped)
>>
>> Unsets json_ouput when using the "-d" flag. Also, since the "-d"
>> daemon behaviour is not immediately obvious, add a 1 line
>> description in the man page.
>>
>> Signed-off-by: ChanderG <mail@chandergovind.org>
> 
> Rather than avoiding the problem, why not have ifstat support json in daemon mode?

