Return-Path: <netdev+bounces-198505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8394EADC746
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EB63A13DF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0232DF3F5;
	Tue, 17 Jun 2025 09:53:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA62C0331;
	Tue, 17 Jun 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154021; cv=none; b=QLValmmQmfS4bScNe8faSCvqDak442sOWDS5OuYqvmjv+tS/uMo0tTWxi5YsSF7/QyRD464CDz3NotkrcyB3f+P+2USiQeRroZcDI+O+3+S1Fvul9J8RoshH88e1JgqbosEyy96elCUtzEiV90UMH96XKI4l1CdzP70ycNquJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154021; c=relaxed/simple;
	bh=WL6I7/r6sNbE9eFLNAU4GntpNQQRjynO7bqQU6HoHyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYa51/ZEoHPTSyuuk4PHYm0kOUPVjWNmWiCOtA/IyoARo1oaOW/jgfFs6+2pGvNi/mACp3FzYRlP/WUedJR7hKNWj4V+KNJ+Lu4AFyYdPgMlYFMvtO2f2MFFjDRO//1dGFvOApsONyltc6UcvLPtfi16tSWfRIQhBc4g1i8Au9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso9983858a12.0;
        Tue, 17 Jun 2025 02:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750154018; x=1750758818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+K8ncmCqlfnbPRcbjEYAOBr5Th8ous3tA4EXtfwmck=;
        b=LewtgoiQfs4PUi6swzxC3YY4b7VUn6xL8LKKETPwJhCvlkaEm2ti0QqhZi6GcE0/Qs
         d2wLpoDOLkLxnP1znvWDJ96SxFecE1e9xJ14ccPhPHeceUaWiNLExZBGUX3N7gw+hRD2
         t9+muj5MuborToxwhFrK9WTwOPLNNknC3Jb4iWndpKRivGlDvUi+UkTOWbBBpMiQaQHX
         +SprpHBm6y88QkvXB1tj4Il4tk5sd3bGWnVTRB+/00FC0zBvgdQQOlJOYyaIIXkf5bkO
         kCDCpbZd9E2FXXRJhbfEHvnxfPufC6SPDMXx7N8JBCnb1HKlBZvRvLxn5byHQpo7scY1
         qktA==
X-Forwarded-Encrypted: i=1; AJvYcCV4KbeJbNWoOJafRMVEYC1JfjjPpJ5QCYSaEq4UPfH4F2QFP31Ks7nowrsocFC7Cfv4ePRg4LcF@vger.kernel.org, AJvYcCWXenPtZtc3+ZlYfXhYswKN4SeeqO2bEqjJuY6+73xp6P7hWV/tvs7toI+tYGRsvrHnCQRSoc5Ofeva9QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7z51PEm/LsJLn5F1nN2GLm1NOV5J8/ztncFmyJfAHTAOak1iT
	9LkdqQ5ZllBSXQQqqZofY6Nvjf9YyA5TGCScSG6BLPQucMqyfiNxWxZC
X-Gm-Gg: ASbGncthUx4ETw4jpESMvqov2yueUXIUULUSsYlcelSVT6a9wYsOgsRonWYm2x9X0aC
	1J3PddHnjyr1MIfj1tusto72BwXHqdidVssg9S0u5H+Xdo72pKTRapO2av7a8/aeLQTxAgIYlij
	oAMxQNnkECDu/KqFVa+LqsXs4P95j2Fp3bk4Q8ZFI3+Ep+1LAj4logJIA0DjI1VI2W8tGaU1NN9
	KG05esdRKFsnlCuCQxoRohHLGUOG04KheXTDLmK/sYMO7XrQJLF58H7HislazjwlnrSpbS5tImw
	8xo7HSl5UfJ9d25WTjk8tFG5S+gwnTKh1FWaazR06u9tdit48pIYxg==
X-Google-Smtp-Source: AGHT+IHs1DZGdF2vTkLpE9hLEA1NqgxZRhxpTQtWLuCQj90mpyRn/L82SIn9CCi2NK5rH/zn1p5jYw==
X-Received: by 2002:a17:906:4fca:b0:ad8:9909:20ac with SMTP id a640c23a62f3a-adfad596675mr1145289666b.50.1750154017358;
        Tue, 17 Jun 2025 02:53:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf7cd4651esm713459166b.6.2025.06.17.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:53:37 -0700 (PDT)
Date: Tue, 17 Jun 2025 02:53:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v5 02/15] docs: Makefile: disable check rules on make
 cleandocs
Message-ID: <aFE7Hj7+3zq1/CqT@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <e19b84bb513ab2e8ed0b465d9cf047a7daea2313.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19b84bb513ab2e8ed0b465d9cf047a7daea2313.1750146719.git.mchehab+huawei@kernel.org>

On Tue, Jun 17, 2025 at 10:01:59AM +0200, Mauro Carvalho Chehab wrote:
> It doesn't make sense to check for missing ABI and documents
> when cleaning the tree.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

