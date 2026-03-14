Return-Path: <netdev+bounces-267740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO/bOQV3tWlG0wAAu9opvQ
	(envelope-from <netdev+bounces-267740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:56:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD028D91A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC6273015E16
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF437D12E;
	Sat, 14 Mar 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnmwtPSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3F37C92F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500151; cv=pass; b=qG8r5rlXKXDUp1MVqsnsLFLq2ppOwH3JjjxbW286Jle9fgXxW5gh48OyGGq4JrUTqsrsD+n+uu83Y8O05fDvMTjk9XFqDv/QueQbhfGl44UsVDbldYQk27b+tIHOd70OFS4hay1CUK4s5ZUnB8fUJ0gvh8OygKk5GzTMBj8MgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500151; c=relaxed/simple;
	bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPQ+R6ZEcBfeDJVwFg1iDr7ZJD4FYrIfGn87AEAuGd6ymfSA+VpxP0s4/Z0GImt7TlwmG/eNK6mIA9voQGsGVS43wqJn/lXCBZSqYvz7GDSz16GoQan6lC5bKYuZJMJ9zUzRVU8VTNhMRVtGvAs++Rf3QcRdzr+PYNCQej01vi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnmwtPSu; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5094e1d17d3so26446331cf.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 07:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773500147; cv=none;
        d=google.com; s=arc-20240605;
        b=X7SDrR2SZfnT9xuJmGGt2UMQnFy6DuK6oMdKhPbXmDilSAQ0XLr2peA59zq7ePdNWS
         herx9DGDtjkJruZXx8ex+/e9fDfkA76lHkL7y61IbrqqJYTvQOZVlTl/VKULWb8U8WbT
         aGmmIY7OKMfIUZlJRBAZ/nfwKMV4l12l+pV7PehdWzAocVVMuw+yFrSPTK+7d6/MPwcT
         2gsFGs5S3QG0XH540iCdqGJ08GMRyHb9SVHjhUevWk/DeHYzSoV8JL2KB7xYkQJk2KJn
         BfiM5iqKBqW5SV3j2W0cABgftDDcDq5rbrly0dnyRmDHyTeO4a2+N4eVXy0wspguu5MT
         uUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        fh=OHtQHObubbi7t8/iUI6sOCha15nZjkrhSNufgx28tEo=;
        b=MGsplhTVFeqJ6CxHpn/g/wtQLVLbGzYBhtBxffBWSP4IviQfVQ04Fp6L+7JaKY8bvz
         AvREPetGTmVAboKf+ZJiEnRBDMQ1tsChLK6x3gk3Lky65LhC08GqKx18ORxdXIXwJc3h
         xfodYvM9saBP6Zq01HrpgBcTy4pQ1L+W8+1Siny5uEeUvrokdpGeomdcJFjOYI1zqAXw
         m96Ri7bQKMk5ic3OmozeHYThFKW3VYI5YyVYriGHNeIoubJSKoqPEELtJK5bg83vn4KP
         mp73TLDjqQdGEgkVtI8ZERZQRwnk/9hjg9oA8XlufaCCiToUCdG0vVXo+KDlvXKhSYOI
         z2Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773500147; x=1774104947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        b=UnmwtPSu8PBpZh9YRmoIKlUGcKidY0LqgrE1SlTuyFCpJmnr1NYCLtl7DzKlcxOjyt
         Km6T2SpRmeCE5VrdTT0K2FWGGJlaDcc2swRMYGnEKyhROPEkrTytz2XAHTnWcRF0/PoH
         u8OsYisk3eNuUEu51gAL64e0uI7blKn38SWI+blhqjs1zj7X8NEJhpZcfRahEmEBf/Yq
         0d1Li4EO88auLuF6ik9WLpFe+lO/HFCG26a6Y7Tx426tiY3mHHF0gXqiqqRKcLTw8gXj
         18tVdqpNNonqZFYp1GqwYlfv+CDHYfyekSrD1QZxZgqQ7OED8mKmnua7k9v+qNtja7yP
         BSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773500147; x=1774104947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ca5kh9peUXUreTgn89AvAH7iYz5iRwVMohpHmv4hihs=;
        b=Vuuvpy5aBaO25nKybtX80tzM5tmw36zzZg9zco570N0FVjvT+QdUE+9buTGRjAEHUA
         4Y8G0yz+HzvJFUv6SOdoKMmpw9r7ESFHfFGQ6+yC/yTsAIkOW2TMOfuJPMsV2N1HOvqh
         BUx2JMW3KxUqYddpTfvOcOW07Gc19X79TvEU7dJUcec42Gyucb27FXBKIyAv9zZsu2zE
         yXL7NRcd5y/Dhqn8XyNCypdZurMMar0+T7C8qQ0jdtmCE/6yWg6bM05LxTFfIE6CnDMc
         9fmaIJrLpuTjcT1I1bm0o6jTZCxOtxp6MIQOrpfGC9XifSUO+fvz6EIm6fxop/b/e94m
         6YSA==
X-Forwarded-Encrypted: i=1; AJvYcCWMNFQ+HzS1C22W0/lxwb59orAoieqQCBrxsSFak4pMZ3eqRjIUHXkbbmMd5qC4m6BRmEHDeTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKq9K/3l18IlMnM+qzpbX3D0CO/k9mkZ78TvcP2oRxRPuO9bU0
	FfZ7s9aJPstbEwrnLIUrRpqYj/XNRLBu5C572g1n88C7yO5zGZKnejankDoQi3+y8MhVTIwRmsH
	briWN6Ae8UNjEi/Uwd/ddV07txPkzRWVCIUvJEunE
X-Gm-Gg: ATEYQzzPJz1u2wn8dH5Y6hFyHrHR1WXDyG5VVmPcr/jOlZFuAk2g7+hgh7pu4p/4Hdn
	Rw+UBrXm5IwCENWTt3wE7YlU5Er4SfPbSgTcIckYZidjL/1Hsjy/DCahKXSaYohaU4YheaevrT2
	eKCH/DUiAkNrCl5KhKF8v3cVozY5sOUsGjAmyUOuVnR2QthWB9qVzXKsnd5VvFzGUQxzrsftAlQ
	31MEqvNbnbrfeW2h6q4xLn8k2aa3XxS/x8Mkc+NTkCGun8b7Vap8GJiGqv9mA6zftGqT92MmhdS
	NI6jab0=
X-Received: by 2002:ac8:7c4d:0:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-50957de8d93mr94929211cf.43.1773500147029; Sat, 14 Mar 2026
 07:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de> <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
In-Reply-To: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 15:55:35 +0100
X-Gm-Features: AaiRm50YYJlq5QX8gZcwi86mWXpn3wuRkajMKwpZDqBSmkf1bay96mdoaMNxTlo
Message-ID: <CANn89i+sEmZxcYDXHE=jtjNxoitGE-z4qkcS_eWSbiWHyNTs2w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56CD028D91A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 4:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

>
> Then add my
> Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, this can be done in a followup.

Jakub/Paolo feel free to apply v3 series if this is still possible.

Thanks !

