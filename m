Return-Path: <netdev+bounces-289091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKolNRgjC2oxDwUAu9opvQ
	(envelope-from <netdev+bounces-289091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:32:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3E56EDF0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5063004634
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0C3FD134;
	Mon, 18 May 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSIV/zeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B63FBECB
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114445; cv=none; b=oJXfEUu6hp4mM6paFyyyZ7SER8jtgTcwFpwg5zY9TkPNhHsfIg2H4cEFZJWCFZob8hvFwcwhoaVQSAEuREGg6pSzxagKM000cczyYO5tJhf6EYBSyUI1f6fohWohnVU/uJ2pz+AM2vz/DTYPEEVxQkPAGa6eETCj2MnZpWmoWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114445; c=relaxed/simple;
	bh=7/5JbgXtZakp8qAu9fde2pP1hH3kxzyf9U26Y/nySWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEU9vt7rnexny6qfZhX1WRf8DIZZKwVN3mFjD/JoZaeOHqe1rFAlq+UCTuCAgMui8cTcfdANbedn94aEh5RGWCVM28lQAFmSAkgb4OIqX1VjWTHANbHnd93qRRRnWapNLGPaoq+ngBlwudw6yDM0wWYug6KzXCIbf4LSjs+aOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSIV/zeM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d734223e4so1450867f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114440; x=1779719240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBsBNTtwVI2xNlfHzXc+UZ4Z+a3F93xqGI/4FrRRBuk=;
        b=YSIV/zeM5KSPwQCDxE+MQAEC5QKx33TQ6w0zX0n6zXiVCuTxHeypqKlYqo0gobK0hr
         hYY7yAt+2zbse6xZ6BiiirxaxSZwOBDVZo3KtAMjge1dMEVuHnIjWilHa7zC6WQ2XuxL
         LNzLppQEVcFR58HN2ocepMUR3oz1cWExV6CswapaL+xis2iWccF5tqbiDaZEmPX8ZDUA
         2sxcXxklmIH8ozaOGSaP4Hf60LbcoqYt65aTZLtDDrptEIzQpJMYO/JB5OgNomRgBez+
         xxYPs0MLZ355PNO2N1vPrZy3xTxPlRv4cf4aUpYw5vmVpZXA2gl+uJrbozGKpM3/IBe8
         H+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114440; x=1779719240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBsBNTtwVI2xNlfHzXc+UZ4Z+a3F93xqGI/4FrRRBuk=;
        b=J5cGDZ55MJLPS5eax/u0fpoPTv7CRMYtkTil3vUAUmqtV8nHWTicK3+lx/eJLiBeLy
         dK3SkO8xYrCuuWGPxGoY58KJT6AKG/zjOPpK8FMnQFtLPsWYLUYb7sqQ5u3RM7FikPEQ
         XqquNIIWLKwUC9Qj3zghJDqs86jbuQDqsFiIIbflZGZHi0AVX99GgaVQr9rNUJllShnh
         obEbh1N/Pg+utmPISRwJ2vtFx5LMfx8LLdiu6Sb+vvjWSFFkQTo3XWk7eOyp5ABlje25
         vnSR5Ru3BonEdr9uw4SiK0n/5zgQQAbjdX28Sh0DxXASPOmvOs1oGDGjghOZ8fe2hpkZ
         MVNw==
X-Forwarded-Encrypted: i=1; AFNElJ86B5vaeBCPJDCqSy19AeGmen0CVqwxzS8S2brd/bGRvIOp4khd6HUKxSG1VnvpGqaF0EyDZ18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cD6Iu/9l+cBuhaNYp5XX8Rwj66LnlnANYcWgTcpQI2LyRDpj
	ghEf/6eaBms8YX5vVuqylbf7JIL+4t34HyOcF9bU2bMZKpeyUehcQjTT
X-Gm-Gg: Acq92OHzjA7JzwX/qllnOvvm79s/KahtlRRI/VB8oiX6ad/wa5WiO/BinZToFzq3enO
	fWZvIhiWdFh0OSGT7Tu74YPU4oXtewc00YriiV3yKomtoqraDdA29OcsdXk72+ZS8VrVrFIlIPl
	WSqNggbFvmq1dXqrg4KCo3Fzd/3I69AoKNA+SD05/5WaWrsMCeU2I2EeBOob46JD5BZGLu77049
	4Mr4WNfqDN7LLPvXjoVNUM4/5vYQByd6fKkSNdNiSjneZjFUIgUbDpxp95zNeRk5PIIbHvvqFPQ
	/BTMYWV7PxBJnTuXaqnKRsuuEdsETQjByKpIzGAZXh+oqXVuEwzzZ2FGLD9sT8rK8V56ERgkjVA
	Ze875JfPLylmnzKbaNzuhG5mEqcx2LYaYwIWo/tuLDGkoIZt2STmjpOhtBVgBqQ/dsHbubC9l9H
	/rQdUGquN68SlbFH7qf7EoXlbCbB/nTQZDIGiXAMQKXCo9Roajqfwk3TM=
X-Received: by 2002:a05:6000:2087:b0:449:31ca:5e53 with SMTP id ffacd0b85a97d-45e5b75624cmr24344453f8f.8.1779114439663;
        Mon, 18 May 2026 07:27:19 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm34825331f8f.0.2026.05.18.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:27:19 -0700 (PDT)
Date: Mon, 18 May 2026 16:27:17 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 5/6] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Message-ID: <agshxWX7r3pDznKC@gmail.com>
References: <20260518122842.218522-6-mahe.tardy@gmail.com>
 <f1c34c53dbda338bac68cdcbb48197412e542040617d8bd04c7c94a0de052f1a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c34c53dbda338bac68cdcbb48197412e542040617d8bd04c7c94a0de052f1a@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	TAGGED_FROM(0.00)[bounces-289091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 43E3E56EDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:21:35PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index 4f0aed8152d3..d0ac0502f6df 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -81,14 +95,13 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
> >  }
> >
> >  static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> > -					    int code)
> > +					    int code, int af, const char *ip)
> >  {
> >  	int srv_fd = -1, client_fd = -1;
> >  	struct sockaddr_in addr;
> >  	socklen_t len = sizeof(addr);
> >
> > -	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
> > -			      TIMEOUT_MS);
> > +	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
> >  	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> >  		return;
> 
> When af is AF_INET6, start_server() creates an IPv6 socket, but addr is
> hardcoded as struct sockaddr_in which is 16 bytes.
> 
> Does this cause getsockname() to silently truncate the 28-byte
> sockaddr_in6 structure because len is initialized to sizeof(addr)?
> 
> While reading addr.sin_port happens to work because sin_port and
> sin6_port share the same offset, would it be better to use struct
> sockaddr_storage here (like in connect_to_fd_nonblock() earlier in the
> file) and extract the port conditionally based on the address family to
> avoid type confusion?
> 
> Note: This concern was raised in v5 review by sashiko-bot@kernel.org,
> but does not appear to have been addressed in v6. See
> https://lore.kernel.org/bpf/20260515204444.D8204C2BCB0@smtp.kernel.org/

Also I have replied in the v5: I don't think we really care about this
since we are just reading the sin_port.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312


