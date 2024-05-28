Return-Path: <netdev+bounces-98622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6998D1EC2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF42824D6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45116F858;
	Tue, 28 May 2024 14:27:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863B16F270
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906474; cv=none; b=DwwITHU1KGrJl5npFmK7uE5ICKBbpDl4O9bRbKDeG+ToAT68cmpdbbfhQWJ7ioKR0OGnDfkoyPSmojYjAeY4XW9ADlJ/7T0HlXPSNrM1iy+mJL9FACmaOqGJGhylFc1wV9uWx/NuRVnJASVvUsse3LkYw09nHOyOQ/FN7SykqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906474; c=relaxed/simple;
	bh=5l/KHbZZnI8VXz6DIFUJPvZvZriYATI/uVRo/tJ6tMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQCTagn7EZFG322IK6faPGubn4V2EUfgne/BdRzy+ybJkroudsJEWnS0aQEN2tGvzdtfM7Y+wxbUu1hMRRCVTSOTX3VtrR9s3/j/g6KrUEhY7+JwYLcJw8aY9p7BAHQRKvSfSFSRzavD1t96qiTgk1n0ibnWUAfpwjaGbk+HW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a635a74e0deso30836266b.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906471; x=1717511271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn5I6sUOIOcgqW/jIohT/sk8NIdnut9/j+KB6otjqHE=;
        b=vqPWgalU7DYEyFRC2zg7cHtFJNTvuutxNQKR8IC+xHqed2Cu1mmFaPIpzTpZhKXmva
         i/tftVDe4p+B8VYvqOPrXHoLTSe3YFbUziHRkexyZNzBErKPCMEIRrYyVmYa0HkS2YyD
         /2qgzEzjp/0xtBU+S57wsGWXr32OBxmYnqbuBpPhP6B5+h8qsvu6pDNlpwq6nz+509lA
         6+1M/xv/lQvVQNJ/pIVW3oZBLsdDsnWiq5bQbBt4QlIE8mWgF8USM6XyM5BgIWIq7KIA
         ADmf4ySloNaOdhqZC0yPozbBo7cDZMpUZsu8vAEwQhfEoagFv0GXT2ULijD+6Gs3N0Hy
         SYAA==
X-Gm-Message-State: AOJu0YzUZZKBG7d5jk2Og0iUn+NDFDuwO1C/jS3qNJTIUsaVB3720M0O
	lVyRmEVQjpYDj53djpirVTLgJGBB8v+2Zkxg5TI4CSDSvC30b/fz
X-Google-Smtp-Source: AGHT+IGkovfoDPK7STF/q+ayyIy4c9629c1P8KwY+70KgGUeYnz5Cwhmw5PH9eVeoF8o+A0FtrUmgQ==
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id a640c23a62f3a-a62643e2436mr750331666b.38.1716906470769;
        Tue, 28 May 2024 07:27:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a632686dccbsm135325566b.75.2024.05.28.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:27:50 -0700 (PDT)
Date: Tue, 28 May 2024 07:27:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/4] doc: netlink: Fix formatting of op flags
 in generated .rst
Message-ID: <ZlXp5GMckD6NYnRl@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
 <20240528140652.9445-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140652.9445-4-donald.hunter@gmail.com>

On Tue, May 28, 2024 at 03:06:51PM +0100, Donald Hunter wrote:
> Generate op flags as an inline list instead of a stringified python
> value.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/net/ynl/ynl-gen-rst.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> index 1096a71d7867..a957725b20dc 100755
> --- a/tools/net/ynl/ynl-gen-rst.py
> +++ b/tools/net/ynl/ynl-gen-rst.py
> @@ -172,7 +172,7 @@ def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
>  
>  def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
>      """Parse operations block"""
> -    preprocessed = ["name", "doc", "title", "do", "dump"]
> +    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
>      linkable = ["fixed-header", "attribute-set"]
>      lines = []
>  
> @@ -188,6 +188,8 @@ def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
>              if key in linkable:
>                  value = rst_ref(namespace, key, value)
>              lines.append(rst_fields(key, value, 0))
> +        if 'flags' in operation:

You probably want to use double quotes (") as the other cases ("do" and
"dump"). Other than that:

Reviwed-by: Breno Leitao <leitao@debian.org>


