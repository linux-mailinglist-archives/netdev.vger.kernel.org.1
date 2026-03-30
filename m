Return-Path: <netdev+bounces-273291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKkeLOa/ymk//wUAu9opvQ
	(envelope-from <netdev+bounces-273291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E935FB97
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7CE03015843
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1493DD537;
	Mon, 30 Mar 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2887gEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498837AA77
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895071; cv=pass; b=HGlJ1UyGiQ7Fd5AeDFb6q64gEnPJ8e0uiQdFfHixulmmCWVsjqXv0pfjd3UWxEJp399J1zmoaLsFvdNgh20mmncWHXMxocvhV9ZQNGnNTuAXvERus8IO0KZWtzNql02T8v0mPqk32ZkPuZiPCXIbYbwXVBAoahi3VCP6sco4Ihc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895071; c=relaxed/simple;
	bh=IjjEjESPBoeuqWEOdgJ68RZQLoI//6qt+g/Spxhh23w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqSPV5yecfjX9cRFbbLnv+ATQgBiUPkQdOPkjQiG4fyYMoN7a41pM99WxH7wnti9vAFQjes2As86sR2CgIfCSXJYiDPQegF5fwuIyWGpSu5qU5t2oHDhxCO615lhV0/wHIqDDG9Zat11MYZ+8/PrTSnmsxIuNP0sNQdT9j9EA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2887gEU; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so8098657a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774895069; cv=none;
        d=google.com; s=arc-20240605;
        b=KzpJHQ+uaFCFWlMbuGc2X3OMIdzFEcQK0nhwg4HtDb3GCPZ5Pwj53wBgii7esnbl54
         MW1ur+O7RpuNR8VJ7K0ctChk3z0gAEqNJUw4hbk/Xd5EiXz0ukirkqlCCPTr6ayYa+B4
         dgf/fsANWV3S4z3HJ2vMssJ6J+ZrJsKFFDM09kxqqyUJwcyHakTeWNpZV3PFg21FXm7z
         kBOqAUbntPq2UE0t82aCHZFeQx76yfr58XJJzcV6tHC6hAMZxgtmV1N0cZ+yepT1YT9C
         EvDTa51J41DSaPZHWx4wpZoG3HjE1bVv5KUsXAywqYD6cf2pzOzQCitBPrM72+GUaaWO
         YC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        fh=VrcR2GePsKuMReko/7RgjPAYOilL3fIfTtoIMK3zh4g=;
        b=fZYHtDnDL564z+1d0+yz31rnvfgIvOaoLQjCG8uNudZnQuYfTiZY7tKwT/vv4hWk+O
         V2MlPNq39LCkYQ2mjmnPnDsUIwef6sh9X/3AnAlmK1fP9U8ubK4+r73cAsntdiG/AFgy
         myvwbyiIV04ESZVD9HNTCVUyobT7cbG5JTlGHlzU7dzNmqx42xKbcufdI9PEytptePIJ
         QfD1dwWMw8lODXwKHcXHpHMqzaOrjAQW9cB1R6jZSEBQx41mESFL3GblPTndKNsCqR8s
         r6Aq6rrdnz6JNpqQk+2A6dHt1E/LHkP2kiSVKkLGKJc1pBB9h4+KQ1xqr61A5eTm++xO
         d3Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895069; x=1775499869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        b=j2887gEUc81/EX3MH8u2giM1vZgTTS/gf8kHV8yd6XehuJ4rxej68kedz00vSNJHGk
         chEajxSdUEJ8TTWW1lWv7NoMKRGToCxnR+C2nytkwgeGnAq7p1kpGjpiVflQzAjMuf/u
         1HDvEf5gQddrfvDVLqeBWZ3xZKFx0C45Gh5dblXcqQCamdLEpoW5siwjbbtzjg4qdrJD
         94QxjNB5z14kUUu83g2aT0EOCHSBUbrPnH7YboaMgv79KjeGRq5MYlRzAD+BJAB7OXCV
         ieKDVvii7O1baCpTP4Hj4YZw2pgWEIerkh/iTlAo7b7sMm1/s+M+M4YD0YJWo1dDOGz0
         zV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895069; x=1775499869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2fCyQVduMiMLHCG7iMXqslB+KxrIKaXOc8AoYNYZto=;
        b=PwhZ5xGwNUX4WnKLxUY9z15sp0yf7ZJHuB99jntEv68R4WlvfC/wIcOlG7sp2CdkCL
         CItKGQNmj7eSdKjlwlMmAvhA+MUD5VrXSgb8wIGF50E+cL88VtyB1nhiSHXwMJ6Fg3cF
         ovjIbskFetA3hQVzVh/q2B699CIT7FQdht8tstSSjHUzFVZYjEPL9r+xyal9qSNGDVIy
         rJYQXkS68HCbLIUDFkVfWMqjJynl7KCg7kqALF+dN+n/ntjEb0tAfAIF/fgdVmUPh+A9
         b4QVg4Cco+tGvC3/+8mPJF0bwkxjOCkmXGnignmLvHYTbkAlkh6qeXjH9BmJ+d9LL00r
         9GYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzBqirK07OtKWWovsD4SgnnYyuzhtUFJLCn6Y3qfOtG1pVaHzGIbvxszF+dRcQYMj9LhmqkwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxecrJWAL+GPM9GtDISZJyyBPqSuabJ6SBdksJ7atnpNZXhwUI
	j6lTm/NbJT4TnNPP1m8D5bTXN2dbtGePLp2VCHqxbHMRA5wSB86TFIMBQD5F2GcjDpl1mAl6i24
	dXf4weZRi2ZusV18q2GJMhe/71Tn5XFc=
X-Gm-Gg: ATEYQzxWRVTmopXu1HMnwGwsOp/7TjuUDgIsnsiqlXlM+bFFWqtqnj+aWeqWoDUeDln
	mFrLhyBJBegjqhCXZeRmscfFoB0YTjJSP75576a9XOcW241XZVZvF8n7WaeGFs6yuOf9NFxH7Gr
	QW/rEnWiCHneT0LPdR3L/HnCV3Z3L5y1OjtM+91xHSuHsKVpGmkpSrkYfK28kNZuXEfNQzEtLRy
	Ipo238vUQtJu+CsUZF7R+Ciy6l7YiWyziVL/GXvGlRfB9B5pt3RBlZ8hVtbgp5E2iPYpqZTDcJo
	kqtr
X-Received: by 2002:a05:6402:144e:b0:66b:eb5a:36ba with SMTP id
 4fb4d7f45d1cf-66beb5a36e2mr3030460a12.0.1774895068601; Mon, 30 Mar 2026
 11:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <acp4BblnJfpVClct@boxer>
In-Reply-To: <acp4BblnJfpVClct@boxer>
From: Matteo Croce <technoboy85@gmail.com>
Date: Mon, 30 Mar 2026 20:23:51 +0200
X-Gm-Features: AQROBzCzCACh_-BLvnQFRTSbj2uJ0Jgxs7I76lfgNyafJtAFK8kadBcN3cI9nxM
Message-ID: <CAFnufp3BRyJUH0J0Q14N0sj50YjC_OqmP49gZ=z75cYER2t-pA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] e1000e: add XDP support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273291-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 213E935FB97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno lun 30 mar 2026 alle ore 15:18 Maciej Fijalkowski
<maciej.fijalkowski@intel.com> ha scritto:
>
> On Mon, Mar 23, 2026 at 07:28:21PM +0100, Matteo Croce wrote:
> > Add XDP support to e1000e driver. First patch adds basic XDP support,
> > while the second one adds support for AF_XDP.
>
> This set has nothing to do with AF_XDP.
>

Should I mention XDP_REDIRECT instead?

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

