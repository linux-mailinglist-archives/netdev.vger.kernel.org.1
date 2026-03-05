Return-Path: <netdev+bounces-264424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJKLOOWWqWlKAgEAu9opvQ
	(envelope-from <netdev+bounces-264424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E0D213BD3
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752A830CD5B1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD225F96D;
	Thu,  5 Mar 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+JtgRqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA6248896
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721054; cv=none; b=aylzzK5MwEzhQLGRE2rZN9nOXl3+YrpOAiK9WJhsJcOo/SJvteNeetNfzkaCcFBNriuxXTKgLO3R9YqzfCbYSFqRYpsJKTbaWgZWYTE+jBzFzvjXvRHMzSpHVm6zMMGaD2iVhH9zz/qIgjXALWfL/r3EINJeXk/xiCZN1TeI52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721054; c=relaxed/simple;
	bh=+B28Mk98IiXMRJvCIsBq5jBBZBywgoYag7pWNkeFnSg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=E0JgcG3eRmuCAQl1VklJ+Odrm1jFGydGgnI0Qj24GpF1WicUk6SRZVt3pi0g8xD25Xi77VjSCxzrtPMW5kPuERdLMJ9dd+d+i57oNnboqoy83mSGHpjHE7zPVGxoION+Sf2nE1mHU+l3ztXY+G/c7AVeMde6N2WD2OoJRl6Fblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+JtgRqy; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad019bbd4so7347303d50.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772721053; x=1773325853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOWKOOJcU3ZrlEEcZWwpRZhg97M/c78tnAB8RTkJgLQ=;
        b=W+JtgRqyAtj5nwMciTgo8koDLzVkU88gleJfCFNSUfFvG4diJ8QHHs7m7nBrYGv6cz
         HA4RgPqV0LzkIeiWIXyzSp77ZVYrrs01TCgJ3kVoMTkY8eH/HHkfMwNReEljviWrbtiy
         IHmKplBNBePf5RzfS7wYLyD8PXJLJUghoIHPxjFXuvJrna7Vc6CGGxym4E/1dAq0DDww
         UQ/kdcgXBsj+SkYXA5v2dP4GSJXqupWCUP3B2ZSp8dhpxK1WSpsf6KFScD2PmjyT5a2L
         aNuotQmhDlT3Z+rl6rbcjjPRPM6CxlXJtmM8ufE2NC+BC+Q0j1lDtQPr4+U2m9n7DoG0
         2PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721053; x=1773325853;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOWKOOJcU3ZrlEEcZWwpRZhg97M/c78tnAB8RTkJgLQ=;
        b=XFUuGUI6GU/nSEmYjgUNhBLDf1GvVCV3SOnb3ToGRSfmncvKCUpzEUvOXmhydcHv5q
         Gp1xaqT0al0RaskJRYR3e9ciJNfUJSVH2S2i+VxT4lvauBjiQhOu8TA8mQJo6jm+f4gl
         idoSsevmC1ZRQ9QF6cvaRgAUMbvn2nz7XNTvNXU8Ydg9QrXmJqdE808/tr8V9ByoTcyq
         2Z08V2ENkKKkhyt7CJFLxWFTbwyfiZ8/bLtW1VnngOl+a+Odu8EMwQA5B5ufVH4dbND8
         NoTPAtSsLyGGdS/SiezHP5Cz/7pMkUZst8FrsoUC9mGyqWESubYhZ+M+/nvxCaToG9Mm
         8jnA==
X-Forwarded-Encrypted: i=1; AJvYcCXAYZYHn9/rWsZkzmFqH3tHRGQl8mG2hiit3Nj7BifUGlzFHg7WJlgtRUbkydCrJScrVt8HTfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrbJFtOVLpOv25ZJS1rK8K8mDLZOlJjRQAFjTtAx4Wc4bzNFC
	a5nvn4EE4UZPlYs8MK6X0SDkUATDS5PX6Sx+Jw4wrVjD7SFRt0Baoh/r
X-Gm-Gg: ATEYQzz++SYTioyIucm80tftUVq6xqcM9WAE36BW/xSJhBLfYLxwj5tgd8KhnJ8Gm2H
	u05JgSE1CRH0UQzCqymq73UYggS4pPX8aLO9NVaxiKUlnHr787h/C7Ei6HM0xvjQAMDXnPtRH8s
	I7+W0VOBvE7V5E7lg/tfGPeptcWNKdvyPqjM68S3n3XAeFT+ngm/NvWo9wrutPkgdKoY3Rv7x0X
	cQNw99mkIZlKtk+6+Q24+PUrLaQCcshSM6dxDrWrnUrikKJvbW1egvEzeryTvHu2VebKZisD43s
	DXIdYZIspc+DiZqTGvVy6MlYsXbcVG2F0G1QF5157e/Ud+/7WULRVD6K6KFPUR0iC9Ne03y22Lg
	SnRLmkQwwol3W0f2IgFm1LH2dF8WfFrtJTjjMhesqFpxIqEtrt/Bcc8p56ZaK/7Z9K7LT6U3Qfe
	CNthsv75KCIIfbxZ+EEhKWxLcDrG+oh+Ux64+Ca7RCc6i3H2qdIYJNvqsDb9v9Z03Rlt5UQRQ=
X-Received: by 2002:a05:690e:449a:b0:649:b943:2ca9 with SMTP id 956f58d0204a3-64cf9b5aec5mr3711413d50.33.1772721052486;
        Thu, 05 Mar 2026 06:30:52 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb75ae57esm8948537d50.9.2026.03.05.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:30:51 -0800 (PST)
Date: Thu, 05 Mar 2026 09:30:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Soichiro Ueda <the.latticeheart@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: Soichiro Ueda <the.latticeheart@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Miao Wang <shankerwangmiao@gmail.com>
Message-ID: <willemdebruijn.kernel.38f5ed88e59df@gmail.com>
In-Reply-To: <20260305070525.184945-1-the.latticeheart@gmail.com>
References: <20260305070525.184945-1-the.latticeheart@gmail.com>
Subject: Re: [PATCH net-next v2] selftests: af_unix: validate SO_PEEK_OFF
 advancement and reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 47E0D213BD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Soichiro Ueda wrote:
> Extend the so_peek_off selftest to ensure the socket peek offset is handled
> correctly after both MSG_PEEK and actual data consumption.
> 
> Verify that the peek offset advances by the same amount as the number of
> bytes read when performing a read with MSG_PEEK.
> 
> After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
> non-peek recv() and verify that it can receive all the content in the
> buffer and SO_PEEK_OFF returns back to 0.
> 
> The verification after actual data consumption was suggested by Miao Wang
> when the original so_peek_off selftest was introduced.
> 
> Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com/
> Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

