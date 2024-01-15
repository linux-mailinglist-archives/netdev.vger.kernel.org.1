Return-Path: <netdev+bounces-63553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF782DEDE
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6562A1C21E84
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 18:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB71805A;
	Mon, 15 Jan 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="T2nyDvqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F818622
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046264so6880805e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 10:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705341911; x=1705946711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYebFm02oQzKSho2r6zut1eAIyUxcztuNRtBzpyES9c=;
        b=T2nyDvqA8Ef2ytacO55Ifrc2iQbForb2eIzGmKfYiSSt4oJ4Bn+CPYEFOO6BbH+C2e
         ssyP6OPdmsqYXencyQN46T/K35s30V8byPuH42t18uEzb3P8Beob6HXHbwfO9QMQQr4s
         Gexvy49Vbz5RJWPnqz+RZdYxoTcZ/EEP4qnu4IMsnf96LC7Am8TjH+wN/GUHHHW1kmCv
         H6LeoSbdsw2aO0rUx2yefZIMenWsYD6RsZd6z9PmJdGKl6fdN6hLz26D/elPBj2yDMr7
         cWC6DIlcn5HQs4v3kz6Md3nI8+DBaTZG83DvpKy+jNZ7HeKvVocs3M7z1ltiY5J0rWed
         BlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705341911; x=1705946711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYebFm02oQzKSho2r6zut1eAIyUxcztuNRtBzpyES9c=;
        b=MQaje3i/64jvyl6qyQ27G+hUpHufqTCocWvjIvHn3EDJkF79i3TKXcOtYNjHwnSXtO
         aoqVIXz2xSHMXhc/lghLA+KMP90rNciBSF5nl1BziW3suzFjbl7PK7Abgi/jy5hJ1W3l
         JK350PUweE4ndUg3r6sIyl5bb7rt8jsc38sf97B4D/8YuJcTjk4DMW7aXXRvbZPYdNYS
         cDZkYe8WD45lceGn/WFPWWid7Z7xGaseBSGVjF2TnA265QPJ4orHocsbtboHP0mRb0En
         1e0uadwRJ8EnLVMkCSKZeXKTQuh+H/8lkM93S3ed1pLa1bO0+0roIIGcQGFyKWz1STLh
         nGiQ==
X-Gm-Message-State: AOJu0YwSofVoQEu9Vk/Y1TUujVAmwn6xBAvq9/WBIQa8mHywKTXxcnrp
	lMUXi+sXYS3BieNZnVgjyI66a6noEABN
X-Google-Smtp-Source: AGHT+IHpC9i2Zt+9OEH1Tthw6TnEM6T2HC0YM/LK4Eu6Lh2rak77Rau9N04giTZ7ccPypztzdYglYw==
X-Received: by 2002:a05:600c:3546:b0:40e:7e0a:65f2 with SMTP id i6-20020a05600c354600b0040e7e0a65f2mr662182wmq.163.1705341911024;
        Mon, 15 Jan 2024 10:05:11 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040d802a7619sm20871602wmb.38.2024.01.15.10.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 10:05:10 -0800 (PST)
Message-ID: <934627c5-eebb-4626-be23-cfb134c01d1a@arista.com>
Date: Mon, 15 Jan 2024 18:05:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] selftests/net: Add TCP-AO key-management test
Content-Language: en-US
To: "Nassiri, Mohammad" <mnassiri@ciena.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Salam Noureddine <noureddine@arista.com>, Bob Gilligan
 <gilligan@arista.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-12-f6c08180b985@arista.com>
 <DM6PR04MB4202DA43D14985A28055CE0FC56F2@DM6PR04MB4202.namprd04.prod.outlook.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <DM6PR04MB4202DA43D14985A28055CE0FC56F2@DM6PR04MB4202.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mohammad,

On 1/12/24 18:57, Nassiri, Mohammad wrote:
>> -----Original Message-----
>> From: Dmitry Safonov <dima@arista.com>
>> Sent: Thursday, December 14, 2023 9:36 PM
> 
>> +
>> +static void end_server(const char *tst_name, int sk,
>> +		       struct tcp_ao_counters *begin) {
>> +	struct tcp_ao_counters end;
>> +
>> +	if (test_get_tcp_ao_counters(sk, &end))
>> +		test_error("test_get_tcp_ao_counters()");
>> +	verify_keys(tst_name, sk, false, true);
>> +
>> +	synchronize_threads(); /* 4: verified => closed */
>> +	close(sk);
>> +
>> +	verify_counters(tst_name, true, false, begin, &end);
> 
> Shouldn't it be reversed instead?
> verify_counters(tst_name, false, true, begin, &end);
> The sk is an accept socket and the function is called by the server.

Good catch!
Do you want to send a patch? :-)

>> +	synchronize_threads(); /* 5: counters */ }
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	test_init(120, server_fn, client_fn);
>> +	return 0;
>> +}
>>
>> --
>> 2.43.0
> 

Thanks,
            Dmitry


