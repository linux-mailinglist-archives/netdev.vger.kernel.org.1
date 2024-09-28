Return-Path: <netdev+bounces-130173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25024988E07
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CBD1F220EC
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE418B1A;
	Sat, 28 Sep 2024 06:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DDE1537D7
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727506090; cv=none; b=p60CLE+5IkX0+dAurawYPicpIiJK4nuXvMM+uOuIQ9M63jkzCqF2pD9PlrXF0yfXB+FvIFo4eyF+/Ph2/hmVGb3nn+PZt5s1EjM64JRjhjYckWk4TVkK6J99rfE/mIjIJL/nebcbhhzaRV5TCDzR913dWP1xPyzRIghHlE+ANFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727506090; c=relaxed/simple;
	bh=nPFdFVn3H56jd88MIwnTVfwf8p9ejxRrsCOrqmW2+UY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mF+oZuUjtJpOI8qyckGm+keybvUUXRYEogc4HPpV2l93Zs1cAHWWnnBYsLbqWOE2DDbLYvM2Jzyp7zYFM/GVBjDsKVHH84Fiz9R2mybl2lhh+naJ4bnnfM9Uli6FlZ23ottm3JAqi89RU+5JwUJ1BSHMcBK3FTsP3tvskC3ZcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd831ab06so780333f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 23:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727506086; x=1728110886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPFdFVn3H56jd88MIwnTVfwf8p9ejxRrsCOrqmW2+UY=;
        b=d+gu8GNpD8R1nJGoXiqGDzxIongoWT/xYVM6VHWsMV6JWcSt5xUtjaAOfUY5d+BDdp
         Dvr4wCeLYjrfRxqBpuJx/h8zLCOLTS4eSQf+QR7cxtyaGdK/6jvo3G9zlWL2g3dAtfsC
         7WGRJrdZmgBYY8q4y8F1vWHdgKltySpmD5KQwnBgrwBYg1Kpw8Ct6aivZgaCToyj3ce/
         PvhNdO3mgdDB/o0emuCP82Wro8QbyHJFDv8J0glxyesVI44QQIgwVZoekCkee2bVF/Om
         ppNJQ3ER7UXyBp/utar/v5f6+qhwhUyOXJs9QpQjT5cf9Q3ly/QsnFKZt80ozb03HfG2
         kkmg==
X-Forwarded-Encrypted: i=1; AJvYcCWdgrVBfI4VqpVGRjBy0RPuPAu+48W2bHYsp1Vmxx+q7TL2pwRmqOjoxOAn2V12aQsXiZnbu1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpryQ6jsdIvlLtXjIO5qlg1DdKi09IebKWv1fRlMnSjUCKusCU
	mocc7hhXs8rojeX11ZqV9zBjlNN76HZRTaNrc8+JtXUDTZrnSLjZdgFguA==
X-Google-Smtp-Source: AGHT+IEKANL8qbanO8qCBodCdC9aLKzzKy+sfeZ2lYO9c0ouFcz/Kwm1DuDd1jqh9LfB9/VWmTkphg==
X-Received: by 2002:adf:f582:0:b0:374:bb32:656c with SMTP id ffacd0b85a97d-37cd5b12572mr3321617f8f.39.1727506085521;
        Fri, 27 Sep 2024 23:48:05 -0700 (PDT)
Received: from [10.148.85.10] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6587sm4066092f8f.47.2024.09.27.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 23:48:03 -0700 (PDT)
Message-ID: <f1d80992b806213e63fe1d6c62c0081c4a24ca62.camel@inf.elte.hu>
Subject: Re: skb_shared_hwstamps ability to handle 64 bit seconds and
 nanoseconds
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Greg Dowd <dowdgreg@gmail.com>, netdev@vger.kernel.org
Date: Sat, 28 Sep 2024 08:48:02 +0200
In-Reply-To: <CADVJWLXQ--JKJzRX6JiEdzq5zPwN+qB65B9j7DTRGJpsTh1eDQ@mail.gmail.com>
References: 
	<CADVJWLXQ--JKJzRX6JiEdzq5zPwN+qB65B9j7DTRGJpsTh1eDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Fri, 2024-09-27 at 09:35 -0700, Greg Dowd wrote:
> Hello all,
> I am not sure if this is the right list but I posted this in newbies
> and got referred here.=C2=A0 Anyone have any insight?
>=20
>=20
> I had a question regarding kernel timestamping.=C2=A0 I see definitions
> for
> SO_TIMESTAMPING_NEW in networking options to allow use of time
> structures containing 64bit timestamps.=C2=A0 However, I don't see any wa=
y
> for skbuff timestamps to pass around structures with 64 bits as the
> skb_shared_hwstamps use a typedef ktime_t which stacks the seconds
> and
> nanoseconds into a single 64bit value.

I'm not sure I get your question. There are functions in
kernel/time/timekeeping.c for conversions between ktime_t and struct
timespec back and forth.

From userspace, you can only use struct timespec, which has sec and
nanosec attributes, all prepared as a CMSG on RX. Same for TX but thats
less interesting unless you want to use SO_TXTIME.

Could you rephrase your question or define the problem you want to
solve?


> I am not sure who maintains this section of the code.=C2=A0 Any ideas?
>=20
> thanks...Greg

Thanks,
Ferenc

