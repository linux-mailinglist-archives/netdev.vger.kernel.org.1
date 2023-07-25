Return-Path: <netdev+bounces-20840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FF761867
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C55C1C20E8F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653DC8C3;
	Tue, 25 Jul 2023 12:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C31F182
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:31:18 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876719AA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:31:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7837329a00aso235996539f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690288276; x=1690893076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1FgvdgVsA8AhmFdAzoWM+AOFT1yafAZy4p4c4o2sIg=;
        b=Hslm1yFyWvTKsfdAP5hMBFuOwahqCUrbTN4iwdv9XCYkkylsRfvUp6ebVsHfjXgL0p
         TQ97kj6HpGjqUAhilqJzfJ+3+TPnY6Qztwra6E2QLB6d4jSlUx7js0EJQGe5HMMCLXrE
         oeW2yNrRGqYJ1Orvmt/D+WLlitXeWDDu/cbinRusP1GE/hcUK57F2hfFUdepWSFl6mBz
         uejroZc4TP3icqz8KG94cU2RAZXT4P1iYOSBWNakRLik5ANkYZcFGnPuWBxS/DQrDEKn
         R2XcP8AS0+lzxQMLvC9YH0dF6TLEtavbgDMBkzgO4ndk1UhCHqF25h9CYaiF/weObPOQ
         VTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288276; x=1690893076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1FgvdgVsA8AhmFdAzoWM+AOFT1yafAZy4p4c4o2sIg=;
        b=cVOCByjI3TAueO6ZnOcCMztWtR6fZ+g6HPdvClAg90022x83yT3MyNH9GR93/3kR6/
         zHmc6SN9X8xS7mF/4H/53135LNq+/9+ZWudHzVQ6UNCUGOCqcox47Rx2D6PKRIRBBtg3
         Dwb8UemeZ34sbEX42j6A4E1+pq9C1+MwcHrPeBqmJXpqcTFuxnhIljLlq8MRV12mTQ1e
         TUAyH7n0/dt/vDqYw+Q8+35pP6cJBhx+tWha+p37ZKxuU1uzRBlB2Sv5fknP6DUszW7v
         P//1AHDMODlY6ofMPaOJ0BYdtArLfFAqggBRcvvq0DPmtswCIHp8iF/TzDSLDOEx6sd/
         L/gA==
X-Gm-Message-State: ABy/qLbGc0BDxQ7aq7VM1VuENYZ32YE8FnOq+tiYI9O0dirJnkDcmmMm
	5xIsg3/w2JR84E+WZEJxfXmlxA==
X-Google-Smtp-Source: APBJJlF9iUN4yUd16TkYLNfCh05utlxera1aImKMVg8l++3z5FT59pZCDICzckk8yXvh57Fw2k7W+w==
X-Received: by 2002:a6b:730c:0:b0:786:e003:1c6a with SMTP id e12-20020a6b730c000000b00786e0031c6amr2483451ioh.21.1690288275982;
        Tue, 25 Jul 2023 05:31:15 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g10-20020a02c54a000000b0042b6ae47f0esm3600276jaj.108.2023.07.25.05.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 05:31:15 -0700 (PDT)
Message-ID: <f0fb38cb-ed2f-d09d-7675-97291d1bc2cc@linaro.org>
Date: Tue, 25 Jul 2023 07:31:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: ipa: only reset hashed tables when supported
To: Greg KH <gregkh@linuxfoundation.org>, Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dianders@chromium.org, caleb.connolly@linaro.org,
 mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230724224106.1688869-1-elder@linaro.org>
 <2023072538-corned-falsify-d054@gregkh>
Content-Language: en-US
From: Alex Elder <alex.elder@linaro.org>
In-Reply-To: <2023072538-corned-falsify-d054@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/23 2:08 AM, Greg KH wrote:
> You sent 2 different versions of this patch?  Which one is for what
> tree?  Is this in Linus's tree already?  If so, what's the git id?

It was a mistake.  I reached out to the netdev maintainers
yesterday to explain and I'm sorry I didn't do the same for
you/stable.

One of those patches will be brought upstream the normal
netdev way.  Back-porting to 6.1 won't work cleanly--and
once it's upstream I'll provide the other one if required.

I'm really sorry to have caused the confusion.

					-Alex

