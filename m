Return-Path: <netdev+bounces-39826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F597C499E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD2E1C20BDD
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C84F9EF;
	Wed, 11 Oct 2023 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WKuo4tle"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2249D2F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:07:18 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D998
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:07:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5044dd5b561so7826886e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697004434; x=1697609234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fif3VA0O3Tp/egVE3up0YdwpQpVNWPEOb2Bm6TakKc=;
        b=WKuo4tlejv9FyV7TIXMLK8oMVStI6HH7zEFOtIua2fV/mbx/TZrSq75UzEdQpCQZu2
         F88JfVpLNILQGVMXajFSls7s61IhK2LKP74Xf4XRllLyofqcyaHSQTJ3hWBBU2Jk8Pmf
         CkQGSNVsOCGlGAD9xyiOB24381fnYyYlH9LfFaoHw45G3POiZGrMNIKyNT5ym6HwxIyd
         OyQBiA2KUzMPsRBUgEhsSoj7Zc4tgXGnvV5Ss6aFxPu16ep5eoQMzrITl0RmtxIjd6tf
         UZWAnkospII7MYWMxFsC/5NKd4i8i6GLOCeHgB7muw4LgPtnWA13bbEWgJ1Kibaz3l6E
         qsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004434; x=1697609234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fif3VA0O3Tp/egVE3up0YdwpQpVNWPEOb2Bm6TakKc=;
        b=OCP/vvJ8UJqJtQ67Az5YKkTyrcir18VLC+GJGlJt/As4DUIsjCkxCV4Z8yTKxt6evt
         zXiDwm6QRlPwDMJoTy7IVxlrw8uhHXv3/HNTOoLXHfF2540E9hxn/UAoizIY1KNmtSd9
         ++ejE1CHRtpF21T9rvMc9o1EjNJk/txl/ciV/WTQlHxy/SCHSokFlCgI3ZnwVG8Yn2DK
         Bq+vKuSp3FWqMfC/LzyGzkxo0E8BLhB/ZNgSxGHu9uh5Qts63B2bO3aKX+xloFs2eThX
         CeqhWV//B4A0YhwVdYro3ijlAKzxe6rUJn5IWKQFycubA4iCetFQb0qaPTk5X8+W6M3J
         0+Vg==
X-Gm-Message-State: AOJu0YxDUpI+6JPMukeHXB3gP79k7s5ZwNfmyHOtEcWbtVCpMovyq1qk
	7JqZRbQebC6gT65UdBS1WFyTQQ==
X-Google-Smtp-Source: AGHT+IGucijjtGbIKEdK01PiV144olbpNiqrnsDK+1XGInQonaIoB1Tvv1V8Qd76gBqKxF2ozi1/0Q==
X-Received: by 2002:a05:6512:3ee:b0:4fe:25bc:71f5 with SMTP id n14-20020a05651203ee00b004fe25bc71f5mr14887781lfq.11.1697004433742;
        Tue, 10 Oct 2023 23:07:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003fefb94ccc9sm15671050wmj.11.2023.10.10.23.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:07:13 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:07:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <ZSY7kHSLKMgXk9Ao@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010115804.761486f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010115804.761486f1@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 08:58:04PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 13:08:21 +0200 Jiri Pirko wrote:
>> Introduce support for forgotten attribute type bitfield32.
>
>s/forgotten//, no family need it so far
>
>> Note that since the generated code works with struct nla_bitfiel32,
>> the generator adds netlink.h to the list of includes for userspace
>> headers. Regenerate the headers.
>
>If all we need it for is bitfield32 it should be added dynamically.
>bitfiled32 is an odd concept.

What do you mean by "added dynamically"?


>
>> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
>> index f9366aaddd21..8192b87b3046 100644
>> --- a/Documentation/netlink/genetlink-c.yaml
>> +++ b/Documentation/netlink/genetlink-c.yaml
>> @@ -144,7 +144,7 @@ properties:
>>                name:
>>                  type: string
>>                type: &attr-type
>> -                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
>> +                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
>>                          string, nest, array-nest, nest-type-value ]
>
>Just for genetlink-legacy, please.

Why? Should be usable for all, same as other types, no?


>Also I think you need to update Documentation.
>
>> +class TypeBitfield32(Type):
>> +    def arg_member(self, ri):
>> +        return [f"const struct nla_bitfield32 *{self.c_name}"]
>> +
>> +    def struct_member(self, ri):
>> +        ri.cw.p(f"struct nla_bitfield32 {self.c_name};")
>
>I think that you can re-implement _complex_member_type() instead
>of these two?

Will check.

>

