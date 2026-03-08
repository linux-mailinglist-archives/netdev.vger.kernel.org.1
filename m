Return-Path: <netdev+bounces-265219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCufLXDorGmLvwEAu9opvQ
	(envelope-from <netdev+bounces-265219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:09:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C3222E652
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C4C301C3E2
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6CA223DC9;
	Sun,  8 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWR+qoNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995115C158
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939374; cv=pass; b=Aas6hxsW3U1znUd/LOKPqNu9qstM/m7mZ81vv60dtUPJb/A1yUdqdydhIFxhD3TBptXZdzwbGlkrrCEz9k8X1JVsg9VlJ8F/V4BuudcmpRCuKooSbZfC9FQ+aJ057rL2nRdal8nehp+BTOtZrjMcMtjG4/pa2dLO89fRNoxV+Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939374; c=relaxed/simple;
	bh=yJ1dqNwa66XIVXfLeylVls9LzfrS+4Zsz/wxO7WEVDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VydjIKJIvSEBTpVoVY7pwmcpnclu74qZCCN4SR9Squu4fT2Ilfr/G5CUHd59uyKi4lY+iUh2dEI4+Woe7jocJ9gvmaR+MPeOCIZo+BNmCJOQ8vPOQcdevBnTghnu1zy+OhHftLli1fn34mbzQCTw180ekbdAaXgoJfPdxPptWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWR+qoNV; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so4047972c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772939372; cv=none;
        d=google.com; s=arc-20240605;
        b=WgaQHb7fPE57voAarMIv1Dfqw7ERMBFw2j35eddkNMZSH6ewzpDTvKNWS4/1actav2
         i3IetUbMaQ4Z930CGXZr5/ZKe4zhQkfCWamq44T/YZryX7K/RQVtQV3pLI3OZ23a8XDT
         w5lzXrQp1eb8+zNRjQlIv52awUJz6O+5a8sYXv3KcsBQ9VPQ6iRRZlmRG0+besXKKIn0
         wDe/1IRhMiso/Rt53ykPYahk3k6KJLCUxm826xE/o/H/gJPCV3uy2sl/Y5C+AmM8rSSG
         C3X7rHNfPwZhvXdyokclRzcPwttA3FE1asx4W2JWODeb0Qg0ccj7Ayd6VXjx2P+4PHbe
         9xFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJ1dqNwa66XIVXfLeylVls9LzfrS+4Zsz/wxO7WEVDU=;
        fh=Y4K0uKuEs8LSkiKsJaTw6x7lTcRXUo5uUg2dM4DlxPY=;
        b=AlwE0YaRcDBJXU8rU/M8Rr/yJhbWsDK/x1o1e1zVVXpF23guTViJnU3ltAv7Oob+Ro
         NiE845dHjN7M83Qwl1plz2kcD6BBdPwzDussSc+63+5zQvxto1UBKVKC8L6PtEDdBeFw
         3SHalTAeCDzmXkiC5WzFhcioxMABrl7YUgCDRU1GMv4JeEZUGFUeMGD725qYQhcOmOFS
         TjPegB5bC+1f+rZ25X10m+ZBh9Vdcqt8vijJ9d1tR2CUC6t5y1lCUiG2OpiuaJKs/ggz
         vPATASi+099365Ey+c70SjzkpzF0I9kyBVOGY7v/Jps1VUWEkcsoq+uGBTdV+FSXgx3y
         rp2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772939372; x=1773544172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ1dqNwa66XIVXfLeylVls9LzfrS+4Zsz/wxO7WEVDU=;
        b=TWR+qoNVroSk60+22Al6E/kaXgCv/0jmlarAxzNUn6d/kG3x2wRlSYVBWYkd1DtVc1
         cpEWajivkOGOhLcQAisnApSpITp03/WPXxMXDO269rQH6a1vzuovcj78FJgAch6obuQn
         TG1J/8YHMQzeNtkI9NgIxHYWdtQDRki4OICptw1xepAH2HhvOr6IoEGYhzY1HtXUICuJ
         4bQQcyuqXy763lKHw4cmHB59zzk6NO1jhi8vmD4yIkiQrak4Z/xXjoRN+2s+6bD5Z6kH
         494SCsyNVbDFgr503Awx1TZ3i4Cy7OUn8Y010hcXBB18UWstBf7Ul1BrCmK12dLp5vB2
         mGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939372; x=1773544172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJ1dqNwa66XIVXfLeylVls9LzfrS+4Zsz/wxO7WEVDU=;
        b=DLNpxbHVzg66iRkq7CcUvDK+O3a0CLwpOTw17sFk+Zdj+YkcUSw6CdF9A7l2E5YGid
         ClSMhP6LvJ31jr+LAe3/FlLArrhQh2yHhGSOS6dCSpDJOg09mw6QLxwE9kkspnCs9po+
         2TZbL1d+bNaEpsXvv5V+1aBRkT5DEh7LMbHU4FfVryKXIYMnS1bjfCkMVXwGwJDlxcW4
         K9V0ZYsSuuLWtSckd3rHIcXMZ2LKuzb6oee4MMaib1K86e/DKF3bJq6QbwE503gOaamT
         Rxfd50VJSQeIM296Kxr+DaOKIHkvVOglANPwekt0YV1SK8obqhu7s66EtoV2JmJ72cmB
         EoVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJLvKVLK+yYFSLTfSJcjahuYA+Es8z0ZFVl2wRvCSo8XolHVRHYNLdDgdkWsnYmVhy6arYefw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOQ17eZ2OTW08LZEm7vwj2BIPLanrpWOarJgOmdEYG/IrKy7K
	mM3pBgKlBrilQ95/ZpICFjaFu32kHDNCCBu+dysu0hRoExiUv0ABfEpIpyD4QNQaxPwXokeAD2J
	hcV/E5fpNcunRZ2aNHJb4Cg62cJE97Ygv+507/OIq
X-Gm-Gg: ATEYQzwv8P4Y80EfrUspeyns22vu8g5fpR7zxw8W7x/OHkcJKPhkX4MyLQSufVi0xEV
	S1WLRdRqY5w53xgYH3HSmIfnUlW21hCny8G0CwWm2C4JFKmxch8VIhgISeIjH4l8G2+89W5lkiA
	tUy9GjWuGICyR5n46lagw0Eq7WRsbYz4d9X8Ez350wx3FecQwh+t/Ooh5FFtsWFfRhMUpVPlXvL
	4PfYBHR8HGtJ4GaaoK/ikG3hA8O+hUrUIzQPXRattl0G2aG4ojGEyKlsNK2w7kkw+fupITFRjyI
	zeUD71UDXtLz5H9ZK7g+l8GF1+AMliubG/DHU0mHZ6eA4tpHRoHdF8DUwD9jdKYsSUmNc0A6
X-Received: by 2002:a05:7022:6283:b0:11d:fb4c:db13 with SMTP id
 a92af1059eb24-128c2db11a8mr3249094c88.14.1772939371509; Sat, 07 Mar 2026
 19:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307092214.2433548-1-edumazet@google.com>
In-Reply-To: <20260307092214.2433548-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Mar 2026 19:09:20 -0800
X-Gm-Features: AaiRm526SyB_j0fll8Ag7zx5PaHUCxdruzy0ZCU0fHah5EVK2M8BQU3zB7zVD4A
Message-ID: <CAAVpQUC3hZYZTMV=7tELB1Tc+y1U=qKQxX5900+FEJAW4JOP+Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sysctl_tcp_shrink_window to
 netns_ipv4_read_txrx group
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 03C3222E652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-265219-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 1:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Commit 18fd64d25422 ("netns-ipv4: reorganize netns_ipv4 fast path
> variables") missed that __tcp_select_window() is reading
> net->ipv4.sysctl_tcp_shrink_window.
>
> Move this field to netns_ipv4_read_txrx group, as __tcp_select_window()
> is used both in tx and rx paths.
>
> Saves a potential cache line miss.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

