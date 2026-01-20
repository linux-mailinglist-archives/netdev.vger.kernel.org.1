Return-Path: <netdev+bounces-251475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BaoODYwcWmcfAAAu9opvQ
	(envelope-from <netdev+bounces-251475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B655CB5D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46DDD883201
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A81426D2F;
	Tue, 20 Jan 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Drdyl/Vp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkvhBGSu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D23A89BD
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911822; cv=none; b=c6RDGdF73xtjT1j0HpFtvMxJPd8dH1+dwOxFMK5Um1JtVEnGjsSvR5dnj97JJb2SQRTvrGmdgwrxdnZpzVVdUuFFRdy19nZONf4Q0Uxqe0p4U1PBMeP0IC+2BLpcO8HEdi6YKhn4RxuppyKvqDV+vlrOMJ4xIjRjw1yZA5iCcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911822; c=relaxed/simple;
	bh=1XPv3uNkmWHVj9nBvtujA7kYi4ti9RusPKYh5MYQv+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuxWXx0cHpuJia+FoxsTtwEmrccNs0jeac3ETQftyYJLytblBxAom6QM3alKdfvfOp25OouNt75Sppf5q13aaMAAR5NBLIpwKbSEnPw82kpOrsq5PHYn4a3S0PxxkIRox+CJgNzGudgDLZKvQptKyTwc8v8OYzhIqwnh0jojSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Drdyl/Vp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkvhBGSu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768911819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEG9JILWJtDxSikxSaJuovdTLx8v+TifArul6/N/tD0=;
	b=Drdyl/VpUYttoby8mcxl7CUbA4qM6usq2UTT3YFy9ghCdUCQfXpUDUzfH0eqVQZtctBTsY
	R+wmAy8tws6uMR8u9Re9Wjcgegnr9ZnBksIVoHpZMBchkRM7Rjc+gZ9daN44bvL+IEabkh
	4QsAY1sI5m6f1sIK1ZvqFer6vO7/tuo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-kkumc4iNOXmpYUOs1S986g-1; Tue, 20 Jan 2026 07:23:38 -0500
X-MC-Unique: kkumc4iNOXmpYUOs1S986g-1
X-Mimecast-MFC-AGG-ID: kkumc4iNOXmpYUOs1S986g_1768911817
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so48999805e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768911817; x=1769516617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEG9JILWJtDxSikxSaJuovdTLx8v+TifArul6/N/tD0=;
        b=EkvhBGSuPfqPRphz7f+oayrtgHhBvdVxYzE5GcF/IyrZA7lM/kGbqA4VS27Ykp9NA1
         0IEzlcHcPAj935jEcGsWeyvOkNedsJiIbPF9FsG9R7rZ1QHH2Xwu3UO2uXJnn4UobcJV
         Kd3tcwi3y4tPZqi3evFqZfbqhP33B5X+/xO1BnUlMJQXMtJfiifOREZsDga1hc3Ea+b+
         zkRyzq8AUwCgBQHRLe059aU/spsq/thxQWl56Dz//LTkGl3olYmyzMCkJBqG97267d0q
         COlWlq8Y2Kou2ZEYkTUPyEzGkMXfnHu+JS0QnpK3qK8iokzuy5TonQLkPfLmkMqT/6Dl
         eeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768911817; x=1769516617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEG9JILWJtDxSikxSaJuovdTLx8v+TifArul6/N/tD0=;
        b=eq0aPVfXnAPaZy7TSiZ6sLUFRYAD3pXE82RVnc3ihY7gYVaLvOiURdlOgDD8a3w6MZ
         q3CY6/HBLJHZZi/z0n9zyPEOIcTOEFkO7491+yTy7gUt3Wx1X1SdSHrLYszNfumiX4bv
         tV+zzV5Ii0fJGr0UiwNDZ30afi/vI2Qnug9eZ3r3guoqN4dP92nC5vrppeJfhL88tYhg
         UUDQrGbgKpWvghlcNRlGjxLkgplFevZgXv1Ckyo6oZeqovHBOtBCR5PNxjJhURtuDpQ/
         MRo/IdjkBTwHylA0oCYpu0tdVsw/p75BrE8eUEyW8FlGgW1CzfnKXebEY99T4DTIpgdT
         sipQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHe1jWoqqXGaqTUsD64PCqSsXBBM1f5VFt0o8zOHBzj65ZNzbIdDy4xsHlEACDkHNbEhJ7x3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyuiWrvZPK07SDwD0vI4e3UhHfj1jj2qOJkzeJXZlsFdDKmgU
	6faxEVNgD1nKiivb6PO5DAxObR0a5PauqXDyeQBP8xhcGcabKW/QfAkR5lz4CVXFXgX6ZvCK+WL
	hqO/MuAvKOYSVGW8yyqA4Jnr1ZnJ7kZ6Qrs8/zPIn3qNPtOCjTY0S09LYrQ==
X-Gm-Gg: AY/fxX6LrB85MAdZ4UZ1Vo2lC5IreEpNWt3XESpEpQYJYOZDSPATuHrsZBY1zwjN7d0
	3zJ6H+sdnof6ANhjyhLcPnO3Ek3y4HwuHNhCpBAyeqKs9X+G3CUrxGXfaO+JPjKH7GpZQ86XEYx
	eIHTKVgXt3DoClgLdhN1OtfVL/ccZswrQ+alxNTuq2O7eGyuLJWqlBUFTRZbD0ZYW+fSxYjMjFW
	j3wCLzSAFKzCrjSD4bKvE39VZXm/9s/SZEJRkcraHEDxYstAylksBMxKWegoDotGm6LZqgFj2Fq
	rogtBLi1FEWUvi4cO0vmqr9gijJ7YXDgVnkib8lHaHpgIiUKZRY1Pr2+x4KpwSTnxW/pjGLB0GV
	E9Xey/my89fMa
X-Received: by 2002:a05:600c:3b1b:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-48041472847mr5520455e9.7.1768911817135;
        Tue, 20 Jan 2026 04:23:37 -0800 (PST)
X-Received: by 2002:a05:600c:3b1b:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-48041472847mr5519745e9.7.1768911816688;
        Tue, 20 Jan 2026 04:23:36 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm247488175e9.1.2026.01.20.04.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:23:36 -0800 (PST)
Message-ID: <a9c9f16b-f695-4009-945c-ac3b03631596@redhat.com>
Date: Tue, 20 Jan 2026 13:23:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/16] quic: provide quic.h header files for
 kernel and userspace
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1768489876.git.lucien.xin@gmail.com>
 <32a34bfa4fcd69de5c738db95dbd71ac8e361d24.1768489876.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <32a34bfa4fcd69de5c738db95dbd71ac8e361d24.1768489876.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[31];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,samba.org:email,ietf.org:url,simula.no:email]
X-Rspamd-Queue-Id: 57B655CB5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 4:11 PM, Xin Long wrote:
> This commit adds quic.h to include/uapi/linux, providing the necessary
> definitions for the QUIC socket API. Exporting this header allows both
> user space applications and kernel subsystems to access QUIC-related
> control messages, socket options, and event/notification interfaces.
> 
> Since kernel_get/setsockopt() is no longer available to kernel consumers,
> a corresponding internal header, include/linux/quic.h, is added. This
> exposes quic_do_get/setsockopt() to handle QUIC socket options directly
> for kernel subsystems.
> 
> Detailed descriptions of these structures are available in [1], and will
> be also provided when adding corresponding socket interfaces in the
> later patches.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-lxin-quic-socket-apis
> 
> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Thomas Dreibholz <dreibh@simula.no>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


