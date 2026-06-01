Return-Path: <netdev+bounces-293556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HGJGVMcHWoeVwkAu9opvQ
	(envelope-from <netdev+bounces-293556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AB619C2D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55C6F3003D04
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140BC3403E2;
	Mon,  1 Jun 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFcOPSmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8033EB1A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292687; cv=pass; b=XeNN7fOFoE+9JLtqImA/h86kVidJh8R7ek4PPodSHWKdtEPbVkAX0aubRh7qFnFy8YBtYzPaWM0HfpfQ3zOXtbFNwYZZRbBcgSM50jrbt6UT1l+Er69Ml0D6syYyYZ2ObcKTo35TH8Lcky8Aj01odiFAE+YQaj1yALICN2LYqtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292687; c=relaxed/simple;
	bh=3SEfUrGpOB+OrS2N/tF2ctbW+WT/uZ3USk5VMcVSXLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx7K7sfJxrEDKmxOhWcynYkvDcJmCr6PdpquYxbQl8kAgq09L8wf118UMxN/kwsNbRCrJZhvXFCawr0MD4qXgU5tACrq4EkJp1+jii5Uq9xxpsaMQ67tB2EvlIymYP8jkwGTTEV9iyHzF2JQyzbvokZPVNCzOSu+eY5KAayiKNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFcOPSmy; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51758478240so1653621cf.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 22:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780292685; cv=none;
        d=google.com; s=arc-20240605;
        b=CAqedALsigfoijxjY8Ntz1Ux/cdIKb+HN/eL8YIpsQaeNc4xSibiSVJMrnzBnQoJuD
         DQhsEmrx40sCmcXhmX5ijyCHsY1N+6pmlHFl6jPgTxvX9GpmqTFfilrfkAHFzZ6gFOSU
         VXXGKGIkzdolHIpI3ITgOaly5kJ1yxX7Ce7iF+NvEQfAInlsjtcJSo0rHRkgOEhMJcoh
         gF0lhvMfU8H7S0/7kcjJ8j2//5vpuC9p9r7KYRqkYwwSRQTcsjW/LZ+2K40nmNnv6HP2
         o3BLEd+CehC+pb6XcoBGLzJhLEPRQfCeQ7GkNr6bJv/m2VCRWJtJKDLA/1uuleVfSrX+
         brxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        fh=SyFG66jC/oVt8C2dXvxTXwjVeBYCSYA5AG/WV5Zdb7M=;
        b=IGLSJSvm/aGkpp3dReWyemI9Bd3+JXz5J24bm0yFR6CYfOwhYmVZqjoulGMJ/y0JRZ
         SuQZXlCsqcq/ihjXwCjuClaoEUUZL/NCHdx7zBShY41sjvfsqV5jpR50Hzm3e0vmZtqr
         MWLvolK5XqjFlDQpqstd5/N9yC9uhzcBHQnISgBHaXtJZCYz9oDHyR70HtOVubRsp3oE
         BuB3LaceoiZDkQ7tb5OtBQ4R1U+Voijt8a094nsGiz1s6Y83SwK20KOGJZc3bXgVH6yF
         nMH7FDOWEsgx645SZFFT8tDRzXJYdrbMAM+pb2vEgRqf9EU/QhxDdDDhWpJrjuFWr6ah
         OYIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780292685; x=1780897485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        b=eFcOPSmysNRzKMC/dOMYuTqrR/SkhfUf3KOewI+3rMotMkgegMaWjLmmj7N0Iab4Fo
         cdEoxnqvSeJupxVKd0Wp+ggTpbzz8lIyxUQhcnGTG7dzt8PP3OJGwWzM01wIpCtQt5ST
         e501O7hVBPRYiHXcLP2oQvVdXNfBD9WZ40IKM+c5s9CFiziKQnO+jzB78bOespbTdyEY
         ocsHHaigV7i6t7ihlqzMLoUopjgWfqQjAN1ObeV0pzrKAnl30ZqKwBMWHU06EzTl2Cct
         CBgeGgjAyCfOgLKWbqBhK1CGzunskMda2fgA8yKeRXZkjGz8I0rG7cGJtNIjJQm6xAqY
         qb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292685; x=1780897485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYJ9us5FFWuw1Ubnqm5Mv6Rgk1trKuije/O9oTp1I54=;
        b=CwOndl/EmckTfvH/WjgvZFjgz4GVcOhANDHMpKy2BFWLT1/jiHoenujw8hFzAbtcIR
         JYEdYvVZfaYSQnq6B0QYCqufBkq+h5CBlBy3OMBv1j8DSvE8G/2vBoguoHRp0xUUV32F
         W7izS8GrD6NN8Bi9ycu2eZe44S/HlN/PDrIGiYeVb9dyHPICq0eCKCi3ElApmJI/+qSI
         BEuaVxVb8QCSr6CqbkbDI9jp7vKupT0qjFgtv53keKXgH1GBg3m6RLckwt/8QK+efk5W
         WevOJV7gwV0RYHxH5ML3WCZprQXOhc3xH5wKT52xfZbomyiz/vNBTqtG5ykLp/e54hCT
         2yeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+M+48xQDyb7PwIIv8AIwcnBrBz+bXcNjgErqAarNyq4obBsaaAr7qgnjKEGNgBDLE3r5wrA4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIbgl6TrIdNZwYND/Heae6XTlyYGNwPxEZzl9fMv9XDh/ff8U
	8dz5FHErJRbb6R8z6MGAQhzYjJzsQuq13+aGoYJwmPSwjEV8FXX7AJG7zbCCW2iniDrtg7VgUrj
	2JizvVHq09cxwgIYka+wyXPmWFNk8jwW60PnIdzLN
X-Gm-Gg: Acq92OFYIBqJBFoD7aHmyHFGA5BTug1n3RUZk4loN4r0/5A6GXm4sAiiNuqKnsvkbHk
	mJ91A2vIWFo2ZDziCAZfeOJhhyK/ilpyEIxldY1odAEaLr7NxjpGz+hIkR0fHrSFXG5NYBjQH61
	Mne+DHTdoeNpsih7DFxoWPyLse0KtE6ivh8dc7H8AbeM73P9VZ93GTkOeI9iOlQZOCrKL5ceiu/
	xPncRYRMrOp7RxmhzSvNLrd8ptvdAmUoYpPCfIMkfkY/7uCnWJLxV5mVyNBnp4LChlBa8xtKqFR
	7GE6noNB2idMSihHA+zaEEJElpag/qyZ7C0l9f/Wudel/oYeKGz7vN6/EiODeyx9ejGFkbOEZg4
	GqQsXP1zYiJvsM2LZ9yXSQLHLQjs3
X-Received: by 2002:a05:622a:1106:b0:517:5790:ff7b with SMTP id
 d75a77b69052e-51757910b7amr22711931cf.57.1780292684284; Sun, 31 May 2026
 22:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-4-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-4-4fc25dfef62e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 22:44:32 -0700
X-Gm-Features: AVHnY4IayHyy6cMDi-nQDDjXrYJHGRD4C69UxZMSkBfLGuSFxlZymzrG3JPQpdU
Message-ID: <CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] mptcp: introduce add_addr_v6_port_drop_ts
 sysctl knob
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293556-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 055AB619C2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 10:24=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> This sysctl is going to be used in the next commits to drop TCP
> timestamps option, to be able to send an ADD_ADDR with a v6 IP address
> and a port number. It is enabled by default.
>
> This knob is explicitly disabled in the MPTCP Join selftest, with the
> "signal addr list progresses after tx drop" subtest, to continue
> verifying the previous behaviour where the ADD_ADDR is not sent due to a
> lack of space.
>
> While at it, move syn_retrans_before_tcp_fallback down from struct
> mptcp_pernet, to avoid creating another 3 bytes hole.
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

...

>  };
> @@ -94,6 +95,11 @@ const char *mptcp_get_scheduler(const struct net *net)
>         return mptcp_get_pernet(net)->scheduler;
>  }
>
> +unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
> +{
> +       return mptcp_get_pernet(net)->add_addr_v6_port_drop_ts;
> +}

Please use READ_ONCE() over sysctls.
This will avoid future patches from KCSAN bots.

