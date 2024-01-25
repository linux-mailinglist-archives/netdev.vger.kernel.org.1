Return-Path: <netdev+bounces-65900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6F83C433
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6535828B202
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F0B6025F;
	Thu, 25 Jan 2024 13:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F654F605;
	Thu, 25 Jan 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191173; cv=none; b=bJoy2DKn3co0xTW9xwkA8vlIKDmoZeRMjIdfwqCwNOnYvcq3w3vluD0qptQZXweEAUjQYHpAi8Qf0YXrU0Z5y++zrQlUEcUhv8wqE+S2ufcOsB+SPaW0C/Q5hGeXPCM3EbVYERy+G7uJXwekXx0nE6CDYtl0oDWnt77CnbIzOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191173; c=relaxed/simple;
	bh=8AGFVASptUqPJ/wFZGmb5DRTaVyYgd1A6i4rBvx5gco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ned/nTtgNwP6/zNi86WgBZSmQMdyo99D705Tw1/aVejWR5FIdaYWuhy3IvWfeXixFT69xImGshFyBBnWMdpld0ZYc8R03LnK2L23lmM645wILeJQAbOfA6V2eo7zejqVBPvSOgNl7Ja1GcchEX7QXXmcUJHcMeKTLn3gPkoD6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so8339455a12.2;
        Thu, 25 Jan 2024 05:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191169; x=1706795969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRt1jnxtIkTBtnjcffX9r8OuG5owutFG9NfxVkKLTL8=;
        b=oRe8GUJDdaXsB83Z4hno5dIdXM/kiWKNdH+4wO1H/YyHpgr2HBxgJ5+t/YhD/aH+4x
         r35ndQ4ZbZy+zYZd6nGHUsC0N5BBAhq/rthHKDDrXyjrXbqP8unvgLFJnQtIfxAImfYY
         9pMP3fNnw1YZfX92NyrESWNE/ux9uSbE2aodrw2uiL+8Yc6iP4ql0ebhwoXjrbkFId+G
         RlJ76a1W/zacwRuv3z6XaVzoiY5qJU3J6UAPuAXTLQwraPHMZIgC+aCr7kb1ZRbuOghx
         7/TdZERcvmnyn1vRaVl/QmfDMBP5v11blbI/klrCBztgJq4fruQ8B7GFjkBcBGXgg12e
         tdaA==
X-Gm-Message-State: AOJu0YysaSHtkO+vfJSZVw/ChI7VL7+PSFsybAfvPnqOoZ1azzXGWx6m
	MSzlb+ht6N8QlWEygH3Y+7dW+EEoyk9c9laeV6oH9WJ8PsGqEkHR
X-Google-Smtp-Source: AGHT+IHcBnHhMWlamXgWfDIupJ18TUEaQILIdLJYl3TEu2Pyr8TdTkS40pJLyPzQ2jikAdxQaVJMzg==
X-Received: by 2002:a17:906:af66:b0:a30:e420:ef9 with SMTP id os6-20020a170906af6600b00a30e4200ef9mr459982ejb.148.1706191169215;
        Thu, 25 Jan 2024 05:59:29 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id hz5-20020a1709072ce500b00a2fd76dddebsm1042880ejc.35.2024.01.25.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:59:28 -0800 (PST)
Date: Thu, 25 Jan 2024 05:59:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 11/12] tools/net/ynl: Add type info to struct
 members in generated docs
Message-ID: <ZbJpPuGP/GcZwhYZ@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-12-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123160538.172-12-donald.hunter@gmail.com>

On Tue, Jan 23, 2024 at 04:05:37PM +0000, Donald Hunter wrote:
> Extend the ynl doc generator to include type information for struct
> members, ignoring the pad type.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/net/ynl/ynl-gen-rst.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> index 262d88f88696..75c969d36b6a 100755
> --- a/tools/net/ynl/ynl-gen-rst.py
> +++ b/tools/net/ynl/ynl-gen-rst.py
> @@ -189,12 +189,20 @@ def parse_operations(operations: List[Dict[str, Any]]) -> str:
>  
>  def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
>      """Parse a list of entries"""
> +    ignored = ["pad"]
>      lines = []
>      for entry in entries:
>          if isinstance(entry, dict):
>              # entries could be a list or a dictionary
> +            field_name = entry.get("name", "")
> +            if field_name in ignored:
> +                continue
> +            type_ = entry.get("type")
> +            struct_ = entry.get("struct")

Where are you using this `struct_` variable ?

Rest of the code it looks good.

