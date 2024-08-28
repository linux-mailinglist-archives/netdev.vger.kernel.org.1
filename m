Return-Path: <netdev+bounces-122841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010B962C37
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB631F23642
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D81A4F09;
	Wed, 28 Aug 2024 15:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF41A4B6F;
	Wed, 28 Aug 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858702; cv=none; b=MHE+Anm2MldJ2NFugGTtyGnA2y1K088sbZQYgcoiRk4Qkzp/d4xgFGT0K6QsoL6JONV8D+HMvPS6iwHkv183UkYyEyiv1hEy3PIwl1QYI1AebVZwAz2g8A2QZ1tIHlP5DA8aO85DtoMY07Tehc4p8dBpVo9T5bY8lmxvHNPeHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858702; c=relaxed/simple;
	bh=4IxNwMj6w0EBoLbnZcM7Gq9cUtz9RnQJQh3TbCsi/sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5rkaBnDHW/Xvz5xmdbPL92A4XPhcUBNV5Wc8Z0ApDUjuflk0bHYGM6FMjoTTLgEhpSsSAoxZuCG6x4ao/O8m8OmYYsEbGVZ/p5aVOcZIWNWjPwwgOaZuU3AszURTai7tZa9XxjeuCOzAoE+bqn84nDrI5j5kfbL7YFNIgzhQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so623761066b.0;
        Wed, 28 Aug 2024 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858699; x=1725463499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9euNMHlr1NHP7Vz0Gc3T71Qk7LPcCyfK5xv3RoeADjI=;
        b=eBva3T9iGjC2E4H2FJnt+xqhpSKIdj8pgmfwZI63fTs44fk1GijOsG9wXJwJvc5V3t
         bS7uJAnSq/dY/iExc9HRzLMPm/bzuPMDPc7LLOWrJOKUrIoRGtSl7iatBFjehYH8Hx26
         IvikFFEdmUPIGN6/8Y6W/5rKrXzrD/Bvdgxk0gNcSxzN8zfWpYQmjnH+nUXh2ttYALjn
         qHqJ1JZLGJyYc+tit/i3SZo4r3/tmjdpGdLmU1qNEN3CuWP5C2QZ5VZgSQsUgNOu9ThP
         G8iWQdpAex31oIlMCjgwJEYPcDWhL4jhAAPdCdvW/gUXv3eBszun7OcqG/wT2u59145x
         O+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx9vGeixADYGrV0+vucGJooGIx5Wh216iGXbObpogo6To8N1tbSOC6VG+vOWqPs9DyFE/iEx5z@vger.kernel.org, AJvYcCXrtQCeOEJ4gkyNBLa9pzmur7v5Iy5yQ38lylorVvuHvN2Gj52zpqA5XctMjkDnN22qFeABXV0i2l7cGl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6p1X0SBqgLI8Ev+K0H8tPCUxncLuITIFi9T3lxjzw6A7m0rM
	vSnHF+cCbJgxVQww37qfeE4jGIemgAIFUvOVnmScwFvNzIGo8Y8K
X-Google-Smtp-Source: AGHT+IGS4aIpIG2ZNa8xlV5teE21L+DnMSaHHkjz7ukKXIj1l3oNF+CwsqeegYD10ty6RhCOpChoFQ==
X-Received: by 2002:a17:907:3e90:b0:a77:b3c4:cd28 with SMTP id a640c23a62f3a-a86a518b759mr1225135166b.9.1724858698706;
        Wed, 28 Aug 2024 08:24:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878a60sm260349066b.174.2024.08.28.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:24:58 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:24:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <Zs9BSOnKVdnsXcRf@gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240824215130.2134153-2-max@kutsevol.com>
 <20240826143546.77669b47@kernel.org>
 <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
 <20240827065938.6b6d3767@kernel.org>
 <CAO6EAnUPrLZzDzm6KJDaej=S4La_z01RHX2WZa3R1wTjPc09RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6EAnUPrLZzDzm6KJDaej=S4La_z01RHX2WZa3R1wTjPc09RQ@mail.gmail.com>

Hello Maksym,

On Wed, Aug 28, 2024 at 11:03:09AM -0400, Maksym Kutsevol wrote:

> > Stats as an array are quite hard to read / understand

> I agree with that.
> I couldn't find examples of multiple values exported as stats from
> configfs. Only from sysfs,
> e.g. https://www.kernel.org/doc/Documentation/block/stat.txt, which
> describes a whitespace
> separated file with stats.
> 
> I want to lean on the opinion of someone more experienced in kernel
> dev on how to proceed here.
> - as is
> - whitespace separated like blockdev stats
> - multiple files and stop talking about it? :)

Do we really need both stats/numbers here? Would it be easier if we just have
a "dropped_packet" counter that count packets that netconsole dropped
for one reason or another?

I don't see statistics for lack of memory in regular netdev interfaces.
We probably don't need it for netconsole.

