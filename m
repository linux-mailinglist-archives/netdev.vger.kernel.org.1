Return-Path: <netdev+bounces-44388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72057D7C57
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35856281DCD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E13C8E8;
	Thu, 26 Oct 2023 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cMM1QL8f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09543C134
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:42:41 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385518D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:42:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c75ceea588so72840466b.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698298957; x=1698903757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y24grfP2O9bkKFNfi9nE2C8WmsiRmXsMIyNLd0DfGLI=;
        b=cMM1QL8fehxyUGzAD+f7G9pxR2r7IzrxK9yF02LbV2G27Y4ezcxPBFykI3QYwj1VBl
         v8ars9oGdVD2njSZnHEQ9Vh/4dq0dIZPVQgkOGHzkHxIbW/zprsHzlKZrMchV96ubBPd
         E+8Hl4zOhDJmoph2pPaDdoV3CyeZxYEMEDvRPEfY59WE5R6uwvjllvmjzVYp5xhM6m5I
         MZmF1sW6KWlW8mxAn7O+765VWzr1nlt8BGWADTl9UC1MocgWc5yYId3uNJnSFEIcBB2g
         NUIRTEUqdxhrAVDE3jH617d9RlkIMBms74yOeoR4wJ19bmkR0I6LrvuCZyytZTG/t1LX
         54eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298957; x=1698903757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y24grfP2O9bkKFNfi9nE2C8WmsiRmXsMIyNLd0DfGLI=;
        b=tPH3+8DhlX82g43AQbXwS0NA7TEZYV/wLXeYZvRYavWKItWUtLF9TyECITeu+2hmps
         b3t4P9pqfqcf9Hpks730htnkh+3k6pRNWMU5uPxWGR3zjs9QYbBe7rFKn7vn1fh4Jnlu
         fFERBXOhtZRCUJFDjsKkXtK5vcTGbX7k9HAhVkJtpqDBXn5SJJcNTK+Rpql3YWSzbmry
         ok+FnGcmIAXYtzWRgBk4UShMZqCM1Lf+r5mCyWn5gVnQWZhzsEr1lIHfWVwJ/LPagn5+
         Ta2dR0tKbXss+uVvgsJgbRenQMGuug2WNdcqTMiHnDHVPcbRgW39Yuu3e8UZ05sCYrji
         sEcg==
X-Gm-Message-State: AOJu0YwwBdISFtOiaXVZ9pTNthL37zMue76UOEDET0uY7rcxv85ffxEH
	qjD79DySDpqtP7pqkzSiF519hg==
X-Google-Smtp-Source: AGHT+IEl1Ar8VIxlTYOKdCpEnFfOMJJmQX54dUHvXfyQxJKC2iDtL2+pn4aKLnucHWQIqgXLp46Bag==
X-Received: by 2002:a17:907:1c9e:b0:9ae:69ff:bcdb with SMTP id nb30-20020a1709071c9e00b009ae69ffbcdbmr15596697ejc.31.1698298957456;
        Wed, 25 Oct 2023 22:42:37 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id li18-20020a170906f99200b0099297782aa9sm10831055ejb.49.2023.10.25.22.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:42:36 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:42:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZTn7v05E2iirB0g2@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
 <20231025175636.2a7858a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025175636.2a7858a6@kernel.org>

Thu, Oct 26, 2023 at 02:56:36AM CEST, kuba@kernel.org wrote:
>On Wed, 25 Oct 2023 11:57:36 +0200 Jiri Pirko wrote:
>> {'129': {'0': b'\x00\x00\x00\x00\x00\x00\x00\x00',
>>          '1': b'\x00\x00\x00\x00\x00\x00\x00\x00',
>>          '2': b'(\x00\x00\x00\x00\x00\x00\x00'},
>>  '132': b'\x00',
>>  '133': b'',
>>  '134': {'0': b''},
>
>I'm not convinced, and still prefer leaving NlAttr objects in place.

If I understand that correctly, you would like to dump the
NlAttr.__repr__() as a printable representation of the objec, correct?

It yes, this is what I wrote in the discussion of v2:

Instead of:
{'129': {'0': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '1': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '2': b'(\x00\x00\x00\x00\x00\x00\x00'},
You'd get:
{'129': {'0': [type:0 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '1': [type:1 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '2': [type:2 len:12] b'(\x00\x00\x00\x00\x00\x00\x00'},
Looks like unnecessary redundant info, I would rather stick with
"as_bin()". __repr__() is printable representation of the whole object,
we just need value here, already have that in a structured object.


What is "type" and "len" good for here?



>-- 
>pw-bot: reject

