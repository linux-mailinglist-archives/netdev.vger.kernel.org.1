Return-Path: <netdev+bounces-98819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A854D8D28F4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60ACD1F23344
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF713F437;
	Tue, 28 May 2024 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nRkk1BG/"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE513D897;
	Tue, 28 May 2024 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940461; cv=none; b=trrHwYqO0MXeX84/9O7VFdARe0zsqE8m5wqCUw+X61HWeH1UPuqx79nKNI8wvRIWUZqkqJF1I2bljjySnljITso/4lpB2Z2am1ZRoxWfuAgw623EH/ph0xl2gNCZdXhr7JOLhrLy+iPaQu2xNplESdTlJRL7g4mbazIE2fkxwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940461; c=relaxed/simple;
	bh=gShILwMjJBDCk7bxa10+DKpVyyvmAskS6Sj1Oh2LJ34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEqH06j7IvdK5CnQZ0B9Awwu3SLOQoRaTs7mvIw4N1LlyBccXenGLpXDaqGDFRjyn/daDLo6o9Pt8Xy1thr7knQFfLpaO3f5hXqAZErUlQL/5qNap0/+Vy5B+3+MS+X1ERvCtrGlt7PUgreuB4LUK17UXEs1ZlCEMT4xcS16jwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nRkk1BG/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 36F542014A;
	Wed, 29 May 2024 07:54:09 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1716940450;
	bh=gShILwMjJBDCk7bxa10+DKpVyyvmAskS6Sj1Oh2LJ34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nRkk1BG/PQkujWt1gGUGlfPIr2mNWhLNiXDwGjQrvFd2wfZ42lW0FBl16JVCnFw1H
	 DRhC3I+LwDUPo6txx+/w+9uzAMvmrqmlklfDoE+w3ZekmqRrL1e9mVew1CL8fKJt07
	 a/YUN8qI/1Ud+AuBK70J28hi+xaQA9fJunPfc/H6r0kSYZ9E79jBVWGbn+6pBY8axH
	 jK86a4YygmyCj5Xls+Hb4zW6hJwyL+nimqM2booGDYXMAgiqV3l6lZQuFybmoioImU
	 imyG0P5RivxyscBDrfF0UpQHo6A2eY3Fb7ebATuzAgks21lrIFztn0CjU1UX2eKyRC
	 QNlBGhRNsDIGA==
Message-ID: <520cf8db945cf8dce4afdaddb59ceda65463a406.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: Add rx trace
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Tal Yacobi <talycb8@gmail.com>, matt@codeconstruct.com.au, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 29 May 2024 07:54:08 +0800
In-Reply-To: <20240528143420.742611-1-talycb8@gmail.com>
References: <20240528143420.742611-1-talycb8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tal,

Thanks for the contribution! Some comments:

> mctp-i2c rx implementation doesn't call
> __i2c_transfer which calls the i2c reply trace function.

No, but we can trace the i2c rx path through the trace_i2c_slave
tracepoint. It is a little messier than tracing trace_i2c_write, but
has been sufficient with the debugging I've needed in the past.

> Add an mctp_reply trace function that will be used instead.

Can you elaborate a little on what you were/are looking to inspect
here? (mainly: which packet fields are you interested in?) That will
help to determine the best approach here.

Cheers,


Jeremy

