Return-Path: <netdev+bounces-44524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 065817D86A9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C1CB21051
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292F381C7;
	Thu, 26 Oct 2023 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LIQnvU67"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF292DF6A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:25:22 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092E183
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:25:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d9d8284abso715111f8f.3
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698337518; x=1698942318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKsb3VEG5BfKcBi/cGsp2V4NSF2IUY7negb+Dw2XBEw=;
        b=LIQnvU67gTB/uuPws9rXjXz5PW05CqOaV0tEXyU5QObwxc80PNN5jsREz+trINan5d
         oUtpiu9gtku6gQE0Rz7C2xWOjOGfIV4R1lp7WVo8J4/3qP4ArfQsH9oeNnBC8qFawbFS
         aHkM8oToK5itnuBGwnsqaTNWsxZVttfLQGRnGWNWwfeQNYyHd7Bj0l7qR6IV9Zyqiw3Y
         WHm0ALfkas4vzF21PhkoMTgpNCuzLDdr11jpfrtHTAp45SePfft/6fU7t6vZtUuBrbVU
         4RqwnpgUWXbmWJXHWgNB1XOsJLx6u5HdMc3pPg1tGvZWf8YiSjxxbidCh9B23OxBRaE2
         VcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698337518; x=1698942318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKsb3VEG5BfKcBi/cGsp2V4NSF2IUY7negb+Dw2XBEw=;
        b=YbnfsAVT3OJiujXnHvv4tvMkV9yKWtSkHnAUSfmrnnJnnbJuluzExW2d8shppDCfHa
         zYCmaqRgIjcZ23xuUYbiQV7/Pwxo+d4xtCegK/cVgtebYHJeubZXBIEAwNgH44gReu6w
         Kid9xzmrO9T+dFahM8+gSAVZYou1LSyrJ1Vs0/QG/+TwidzjeDWb8qgT1MpHSNT5hske
         rxDjHU7k8uf0RVSmsRdnDrxVqks1W8lefz5drQYuVr8nSJwEpUVaZJLmVbBy5A7yigdv
         taSthKEj4875F/z1fR2Wg1Yc56YZPvB4/OvnpBTh43Ft4AB60ySkq8zmyzUnWemFdIPV
         AvsA==
X-Gm-Message-State: AOJu0YxrXrYZMWuYWHDgkwNem1H5bCtABEvu2W860dhoQOk0PhniYc8O
	ISi+ACDIZWv4UxrZJvvcGC5vrg==
X-Google-Smtp-Source: AGHT+IGVNQLqOdH4Y2+0T1GV9BoCmE4NqPyDUYfn1aDU0G+hoihWPXoOeNVyfxlGcGHr3RKvE3rvqA==
X-Received: by 2002:a5d:5e87:0:b0:32d:a427:7fda with SMTP id ck7-20020a5d5e87000000b0032da4277fdamr118452wrb.48.1698337517982;
        Thu, 26 Oct 2023 09:25:17 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm14590182wrq.51.2023.10.26.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:25:17 -0700 (PDT)
Date: Thu, 26 Oct 2023 18:25:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZTqS6hePUFrxuBLM@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
 <20231025175636.2a7858a6@kernel.org>
 <ZTn7v05E2iirB0g2@nanopsycho>
 <20231026074120.6c1b9fb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026074120.6c1b9fb5@kernel.org>

Thu, Oct 26, 2023 at 04:41:20PM CEST, kuba@kernel.org wrote:
>On Thu, 26 Oct 2023 07:42:33 +0200 Jiri Pirko wrote:
>> {'129': {'0': [type:0 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>>          '1': [type:1 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>>          '2': [type:2 len:12] b'(\x00\x00\x00\x00\x00\x00\x00'},
>> Looks like unnecessary redundant info, I would rather stick with
>> "as_bin()". __repr__() is printable representation of the whole object,
>> we just need value here, already have that in a structured object.
>> 
>> 
>> What is "type" and "len" good for here?
>
>I already gave you a longer explanation, if you don't like the
>duplication, how about you stop keying them on a (stringified?!) id.

I don't care that much, it just looks weird :)

