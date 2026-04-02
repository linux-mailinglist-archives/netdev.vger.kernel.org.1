Return-Path: <netdev+bounces-274462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFlKC9VGzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7196F387CA6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF77F300DE0F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304C2D3ED2;
	Thu,  2 Apr 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YSZTZQyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB539447C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126105; cv=pass; b=nikhguqLcZIIoHrf8gWxOG346OjBVzOAd+PaYNnS/OccPs9xUjltQXdNQ2uHUacbDaxy/l8BEjom33sj4m0z0j4yjAYsSxNiAgeHAlb7vt050bLDo+NGC+MYfoM9ZYzAl6CnCKvgUo5SuOazbP5AON4I/NndUmUHq90wFDb3OfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126105; c=relaxed/simple;
	bh=yMRN8K1zMVL9jUZ54TJQDnn6aTqo1k/hpoiy3zlyGRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVM31IizvhUpmZ9vvvSjpem0LCn1nvemfEZXQNd9kwIaCSVjSUq+a6C70VbVHDJ32AjQGQathLKJvTKRFQmJoz3eHKlJ+sPVbcX/BzKW7pQqjfhatJLc+l4IXqqju0h5TGt3qNoNJ6spYZTqzCiXP+Qjb4/YeljoAtlBzmmpYKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YSZTZQyR; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79827d28fc4so6032587b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775126103; cv=none;
        d=google.com; s=arc-20240605;
        b=g5XGZDyxunW4ouyIIRUKRwykLQDC59m1OCtfXBy7I4J6gD1yDFlwpkx+5w+w7Z+hYB
         dfCYNOY/2UrLzPSGb+5I/F5spfz2YR/HzXU2oGOiAhpdUr1ci9JoGXLjTOOSYRlwEi4l
         g7BSUhJR0i3cxwDM4FOPbC+K8utIn8+CXLwbVgy55sjh13HNPEVPs9BvvxEXE8Iz4XpG
         yWoCHwTGY/lhdQ113z/apxPeXYeUHvuTVF+0zUW+ZjU3fgkPiK+4CVLog+U5CAoP83bS
         ghvNYcda7YUzWvMcaS+shyn17m7hbF2jhv+ouoouo/eHxehWbv8qHdHTN/SRy+bylJXc
         F4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pqe5mFprvVvrkxjZm7CpIpzEuH/9aymSbKyUSTVCLkA=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=INCneAnmCiWETG1gfC3Y5fE6oohY/ivgWMCVtHF11MsQPVqIEyNLgIDr55XZfMt9f7
         8PbSyL0rYtTkp0C5+BIFaGk3BoctHjlkkSfdfff5A8y0hCM0Pvf8DMYe3d158G/6Uveh
         1c/gWnJXDRgNrnMgoqzcpG3Tetsyj7bplzwH3HgYj9HXPK6kLj24iKF/00cBM5b11mIm
         Pt5sZbclvAQDcVQr9C3aVmMsaledcamShHUsJWNwSDPJYGN9ZADAmAcQkfPy0VjnJZY1
         fny4n3W7aczszeMpibm+1PEvn0v7UtNy8kusBC29Cz+v/2FDUVPVxqLZ316XKWuRWRmX
         obkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775126103; x=1775730903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqe5mFprvVvrkxjZm7CpIpzEuH/9aymSbKyUSTVCLkA=;
        b=YSZTZQyRAUvMidz8ksdDTuEFPTZupaU8iLVfEkWJDWSgvN2evy4ntOrSZBPvSmA9KR
         k3p8wLbRjp2uLeG5lw+DBhVQAT4W1UxvfSt3cQM1jMToW8s0vRHUB9+hBUIcjm9rf7YI
         L1F8snf+V0klCJGDOFuGVs/evVoom5gU4o0CIPm8LfTs4wNlKASHuUIUHoCKj76FRe33
         Zi8m+DNnkrXZ3uDcBR/VBOHBQpWL31IaYUzdyy9SPFunrTKToAF6sMOslrHIIICRBNBn
         wrhFOCgShz0W5V2meX/ifMbIyyZAdj3coeH4A4k/7jZGE0LlsPjlnVl+sGc/HKbEAxYu
         Ikyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126103; x=1775730903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pqe5mFprvVvrkxjZm7CpIpzEuH/9aymSbKyUSTVCLkA=;
        b=jkvkV/cJ5PcBxvrh/a9FP0nEzFbJZvJp9xLUq0QKT/HGDeDUcSU1HXnNFCVWv7BQlZ
         kGZm/LGtcyGqPOAbzlGcYPcJphQz0Jn0LnYu6uMn+uYTCXhOC/NVmBVpj9HXQoTQh2Sh
         CGdmapDM1k9oICZRK588xw1OavPbsPoAZC8V0mbInBzr5fkvWGpFRXqtvEj93Yee/kzz
         Qt9wZnhebib0vWJhwL48YEYKSFyicTFQAbMZXTp5EW8vsZHC1IAWCo8/zOcmxTkxpoKR
         Mk0a4kjnn2wR2wXTBAE3/We1Qm54rIYfZjl4W8gWkT32lXv4enivGincGVTA4uptsf3L
         fNHw==
X-Gm-Message-State: AOJu0YzbFFkb8uE7vxLM0FUka0g61cIN1YnZUVrFWpsh5cp7yxZdhdsI
	Xco4SuJxsfPne3vMDP2/1E8Orp+98alv/K1RFXc1fGf9p8s+uq+ARoC6eEUZtP3XUvLyJw87cr0
	F5D9KKQZYCR5uMg8V4nIW4da0aulcHWgKh3/T9zvh6EXbhxt0Nz7mjA==
X-Gm-Gg: AeBDieuEFzzROftwyunwUZsfUp2whN39p3ObQkVhNNaRAJAY8K9P/qwTFxZgfegHIMV
	MfEHIQaufNWhWoPdcwZ06CW6ZwRDPqHnp721vtiaDM+oRDz/EjAnmuqORAf6wVpzkaPr2Y0v9gw
	B8pjlk08+FmLUkppt5DN2D562mPFgN/ASKC/rRV+2iL1ZFv8orhC9P6iR7VqeEVzojuOLjDkUnY
	WwlZaj6q25WowHpusqeXezbTpfAyLgcddYk0Eeqf33ImoMpLuS+H3WoOCdhf2t3wCtyZ9MyZeq2
	At7OeW7tMmcYfgx5gwM=
X-Received: by 2002:a05:690c:9201:b0:79d:81a:1f86 with SMTP id
 00721157ae682-7a21214be50mr62482277b3.31.1775126103189; Thu, 02 Apr 2026
 03:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331050217.504278-1-xmei5@asu.edu> <20260331050217.504278-3-xmei5@asu.edu>
In-Reply-To: <20260331050217.504278-3-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 2 Apr 2026 06:34:51 -0400
X-Gm-Features: AQROBzDWT4ktlzTU3TnLe2BAisP0IdF0COzt5fDbmQ2mFbyO0uVuBmEIJSl6-KQ
Message-ID: <CAM0EoMmmRDx_as5obeXbh46stSuCHe=RA0KpZSpgA915xNar1A@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] selftests/tc-testing: add tests for cls_fw and
 cls_flow on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274462-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: 7196F387CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 1:02=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> Regression tests for the shared-block NULL derefs fixed in the previous
> two patches:
>
>   - fw: attempt to attach an empty fw filter to a shared block and
>     verify the configuration is rejected with EINVAL.
>   - flow: create a flow filter on a shared block without a baseclass
>     and verify the configuration is rejected with EINVAL.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

