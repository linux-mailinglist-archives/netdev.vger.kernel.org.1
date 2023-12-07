Return-Path: <netdev+bounces-54819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547838085D6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868751C20DAB
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0EE35880;
	Thu,  7 Dec 2023 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ntBFraEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAD131
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:55:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54cc60f3613so1033905a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701946534; x=1702551334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXxDJGtmjiM22FEkVERK8ySPEzsoGKIm7RSPRTPokbM=;
        b=ntBFraEhWOPM9gWF8t2miBcfUf69YwQEucEm9cHd0YPrL+stwzOr+BZsv+M6QYugeV
         bAswLwnhy1qghfGv/KSNyFoGOozjByn4sYhoy0xxB5S+M8AK8dr75p4csDGihyskfkTU
         R1Rfl0DcO+pHxjhIkDJlYX0Uh1EXIhYrFGI2I8ReJk1u/EN2tEAuSGqhzGs9rsggRTfL
         OM6AWuHEWE/0+lHDKrEK9SaL3t7SzAgG5/XZrjhXPoIdKRKBAcZ2BHX6pnbdDJCjMMtx
         vgjrX26VQXZuA7JWznPpLzGjyTOM5CLmyeyVCSvoD+Nr7WsxEiU5dTnV8IJCWQHUZEUK
         dsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946534; x=1702551334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXxDJGtmjiM22FEkVERK8ySPEzsoGKIm7RSPRTPokbM=;
        b=JU8Sqt1CSAg/rJ9BCkpFl6I6TXYT/sWbwsb0y3ZZUnJBD88gUkn9xGbWoPIJ9n4m8Z
         Z68KYw+OmFHB//8F1sgY5hQNfAZ6PgdtNlE8bfY+uJAP7TRirkgU5rRGsA9F2HDbS/Sb
         S6BCKYB0lJEGqJ9Q/Rx4rbEzvtAV/72+RAERKuhalok0Xiv70lX6ZN4LbIaAHzmSrPH5
         DDy1h77SGx6gK4SNT/x5N9HrH+g5JQGGvnGvtX1C6+X5h8uuJCtgZMqDb9fzzivRF7kA
         0UvfKVUIkm1spTQ9GCpGHUyFKgDHH78yiLXLLCo6LT2xyqmfD9ZmhDZO+31YrtoPGdHs
         MUMw==
X-Gm-Message-State: AOJu0YxIuWicpDe5JeE2mAmLSNuADw35Dv7zGYnqqR4MGl7EC2Mtidf1
	p+rpv+RszuVtSIlCFse38gsrJg==
X-Google-Smtp-Source: AGHT+IEI2ozgLa9f4Uirnyi4SWmkF9wnW6TZz68sJgvSnNdkJ0YfUlzWdGUYslowf+6iG4cyCQ57Xg==
X-Received: by 2002:aa7:c3c8:0:b0:54b:5170:5cd2 with SMTP id l8-20020aa7c3c8000000b0054b51705cd2mr1387410edr.20.1701946533802;
        Thu, 07 Dec 2023 02:55:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q30-20020a50cc9e000000b0054b1360dd03sm651871edi.58.2023.12.07.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:55:33 -0800 (PST)
Date: Thu, 7 Dec 2023 11:55:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com,
	horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, konguyen@redhat.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v2] octeon_ep: explicitly test for firmware ready
 value
Message-ID: <ZXGkpGuJSCds5idf@nanopsycho>
References: <20231207074936.2597889-1-srasheed@marvell.com>
 <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>

Thu, Dec 07, 2023 at 09:45:15AM CET, mschmidt@redhat.com wrote:
>On Thu, Dec 7, 2023 at 8:50 AM Shinas Rasheed <srasheed@marvell.com> wrote:
>>
>> The firmware ready value is 1, and get firmware ready status
>> function should explicitly test for that value. The firmware
>> ready value read will be 2 after driver load, and on unbind
>> till firmware rewrites the firmware ready back to 0, the value
>> seen by driver will be 2, which should be regarded as not ready.
>>
>> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
>> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
>> ---
>> V2:
>>   - Fixed redundant logic
>>
>> V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell.com/
>>
>>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> index 552970c7dec0..b8ae269f6f97 100644
>> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> @@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pdev)
>>
>>                 pci_read_config_byte(pdev, (pos + 8), &status);
>>                 dev_info(&pdev->dev, "Firmware ready status = %u\n", status);
>> -               return status;
>> +#define FW_STATUS_READY 1ULL
>> +               return (status == FW_STATUS_READY);
>
>The parentheses are not necessary, but if you find it better readable
>this way, so be it.

Well, since return is not a function, parentheses should not be here.
Please drop them.


>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>
>>         }
>>         return false;
>>  }
>> --
>> 2.25.1
>>
>
>

