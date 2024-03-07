Return-Path: <netdev+bounces-78313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC769874AE0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AE8287D26
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B7839FD;
	Thu,  7 Mar 2024 09:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16142044
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803883; cv=none; b=nCvV8FIw+g8M1a1ptmxbKw15UvzRL+zEDdUpewDqwem/rlYETkTzG6WEJE+nJxcjNMrdEHSsIf0bfeRwjKiDG3qRelePA5bosRS8GUvZ4voC+3Z5KWO5qQNe8qbZn5b6eABXiJ8GtEu9uK+mpW20kN30EcOaFx6DQv6tV6sl9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803883; c=relaxed/simple;
	bh=ocCX6usaz8QdfkRCgd1MS9hwZTu/JQeu3kQGFhIWJaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX5h+IwYMymYXco3/2qclhEkGfApqvu3mOxIA1pp77NlPKWl1W6dR65QIbw1uxAvcbZ5UXpSAno+N9ts39cCWZSdqBnRb+sst84NfQ0ZrqGfvVT34wZvcifVKhKHERc67khubxvgnDbWZUSAO5JWbgoZHHJVVhsteuNPaYJYq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d311081954so6544251fa.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803880; x=1710408680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txzqTrLakv/r2+E61MB9WWywMRbCkC28EGRtkqu1OMU=;
        b=aOBXTbuUuDIPJ5CxldwgrhCmx7YBM7pK4zDYYWLU663jP01HiHIQP2rtVO4zp54nDq
         ltEMB3Au9QSio6gurdeOpft6ov3zzp/BI1Ji5TThn890oUvjUhI6d+xwyyY+IPmydStb
         5J+kmWXLha1oNCqg3MXINZZ0y5Hkp6ddL+3wgLDl25pKyfcibWqYzSS29JC0FRoEu4fe
         KabtWuShMbR06/JR79u1xZFBwd7b9fo8YtPX65J/H32ws7JfoX47gexSQ39vruBTrz9y
         X7rilrVbVTO05K3RPGiX0G6d3Rrnmoxz4SzUsQQaWphQkvLeaCOI0I3u9aDG09nYKQ9n
         MeyA==
X-Gm-Message-State: AOJu0YxWWkD7I3Vk2v0aO74hIztiR4hPB2v9jpuiEZVbg9tNM9U4c79U
	vcMBjb1QQB30htfVG3kXOtPwevii8aFmAjhzt/CKlqjs9SVGvsKG
X-Google-Smtp-Source: AGHT+IHRL11Dv+iss/kO4aZWDBMFOn3vTcpZatBr5LSm/2gmbU7//LBjCZsU3cqCUyOTxsSxSacljA==
X-Received: by 2002:a05:651c:220c:b0:2d3:36d6:aeae with SMTP id y12-20020a05651c220c00b002d336d6aeaemr1126802ljq.5.1709803879495;
        Thu, 07 Mar 2024 01:31:19 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640243c800b00567fd12c7f8sm1130900edc.60.2024.03.07.01.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:31:19 -0800 (PST)
Date: Thu, 7 Mar 2024 01:31:16 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@google.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors
 without stacktrace
Message-ID: <ZemJZPySuUyGlMTu@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
 <20240306231046.97158-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306231046.97158-3-donald.hunter@gmail.com>

Hello Donald,

On Wed, Mar 06, 2024 at 11:10:42PM +0000, Donald Hunter wrote:
> ynl does not handle NlError exceptions so they get reported like program
> failures. Handle the NlError exceptions and report the netlink errors
> more cleanly.
> 
> Example now:
> 
> Netlink error: No such file or directory
> nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -2	extack: {'bad-attr': '.op'}
> 
> Example before:
> 
> Traceback (most recent call last):
>   File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 81, in <module>
>     main()
>   File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 69, in main
>     reply = ynl.dump(args.dump, attrs)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 906, in dump
>     return self._op(method, vals, [], dump=True)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 872, in _op
>     raise NlError(nl_msg)
> lib.ynl.NlError: Netlink error: No such file or directory
> nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -2	extack: {'bad-attr': '.op'}

Basically this is just hidding the stack, which may make it harder for
someone not used to the code to find the problem.

Usually fatal exception is handled to make the error more meaningful,
i.e, better than just the exception message + stack. Hidding the stack
and exitting may make the error less meaningful.

On a different topic, I am wondering if we want to add type hitting for
these python program. They make the review process easier, and the
development a bit more structured. (Maybe that is what we expect from
upcoming new python code in netdev?!)

If that is where we want to go, this is *not*, by any mean, a blocker to
this code. Maybe something we can add to our public ToDo list (CC:
Jakub).

