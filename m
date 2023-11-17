Return-Path: <netdev+bounces-48780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249A77EF7F3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7D1C2082A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D93715D;
	Fri, 17 Nov 2023 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="CtUwKuYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8CD5D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 11:43:24 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-357cc880bd8so8686655ab.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1700250203; x=1700855003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXvwV7OeTmw9fKUirgnxjsXC9lnTwxzDGxfu0odsQUc=;
        b=CtUwKuYfGKcW6PE0jHeAA1NUeFD4rjwUrNBl128Nk2t6KJVEMIS6CHudaExyppBbuO
         /jwt6GGUW5lqGeeU/a29akUlNXv3gv8+6ZLMGlYwKsCDy6fX8M5TJSaEdxeHTQz7I3sP
         o/gANkf8Z6cuwS01BtanAa0dBoLB8XaXRg6hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250203; x=1700855003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXvwV7OeTmw9fKUirgnxjsXC9lnTwxzDGxfu0odsQUc=;
        b=WB+cVztO9N0iAsncB43FDBNivPiA4c98STL/3j9VB8TwVpoVbYg+RkDcoEXmgDDrr0
         mcNuE6hZZvcNOCzi+mn7Cwe3F98FYBESPu2GQSDgql4TQdJT6kF1oUkQ3Vt46x0JD6Cl
         Y2DgqeWo3XSvnTNj87zDhB8O8O7OpjGjf7fec1EW0t/eMopfQ2TIkuUSLECVnROryqCF
         pFZCZ6LgwhCkk0KBxjXntX4x4d4x/8dQEO/2fNr+AMpCkV8mwz295yAoUfFD6SogL4Ct
         EOTO66Rq8SQEcXXXzXWjyLvuCJIHk4AXwmDB6nT8cfYHgRpCJNoiRI5rxVgvSNdVy1nN
         m0bQ==
X-Gm-Message-State: AOJu0YxHUWgYO/035xPSnwX9PbqQTWxZMvifLSCTDWjeIFiU/VF5KgT2
	cJxhA2XpDaihQzsGM5PY9Ca7gUfn3HIHH4jKAEI=
X-Google-Smtp-Source: AGHT+IGy1Xgw8s5JnD31WebpvOqYE/s3quKYuSGaapJpUuXLQwiIyaIJT+CUeI8hdktP6wtVEvI3ig==
X-Received: by 2002:a92:320d:0:b0:359:30b1:4265 with SMTP id z13-20020a92320d000000b0035930b14265mr539295ile.4.1700250203505;
        Fri, 17 Nov 2023 11:43:23 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id i4-20020a056e02152400b0035134f1a240sm650212ilu.86.2023.11.17.11.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 11:43:22 -0800 (PST)
Message-ID: <11f2d507-232c-493f-8efd-882f0330f7bd@ieee.org>
Date: Fri, 17 Nov 2023 13:43:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] net: ipa: Don't error out in .remove()
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel@pengutronix.de
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-2-u.kleine-koenig@pengutronix.de>
 <79f4a1ff-c4af-45be-b15c-fa07bc67f449@ieee.org>
 <20231117144505.yfilrqpfbdhnhcds@pengutronix.de>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20231117144505.yfilrqpfbdhnhcds@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/23 8:45 AM, Uwe Kleine-König wrote:
>>> Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
>> Is this really a bug fix?  This code was doing the right
>> thing even if the caller was not.
> Yes, since cdf2e9419dd9 the driver is leaking resources if
> ipa_modem_stop() fails. I call that a bug.

I understand that.  But the alternative is that we free
those resources and allow the hardware to (eventually)
complete an in-flight operation that touches one of those
resources, which is a use-after-free (rather than a leak),
and I call that a bug too.

The function was returning an error to the caller to
indicate the request failed.  I'm comfortable with
accepting that and just issuing a warning and returning
no error.

The reason I wanted more time to review was that I want to
walk through that code path again and decide which of the
bugs I'd rather keep--and I think it would be the resource
leak.

It's also possible the cleanup function can preclude any
later completion from causing a problem, which would be
the best.  I just don't remember without looking at it
again closely.

					-Alex

