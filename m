Return-Path: <netdev+bounces-286451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL8TDtdgAWq4XAEAu9opvQ
	(envelope-from <netdev+bounces-286451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F43507E9D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9AE300B11C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886D3624CF;
	Mon, 11 May 2026 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o39iGH2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE12727F3
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475209; cv=pass; b=ZqlJLcRpCAI74j2zgk6ySx3opNxL/sEzOJKLNCoLFiwPZRtPSbT+aW32qdybubYJZQVdriVp6hsaPQYx0FWz4WHuVI8lLIocTa7wNRx3SAHVkHG+wIQ146GdocgTn3T7iDDSCuKTh/wQNUa+MzbixCc1oFBFfnSHJFIwOVdn5UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475209; c=relaxed/simple;
	bh=zloL9Ed0rrrYtG/ynMpJyid/W/AK7sYyEspxhHOS44M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB9T+O77exCT7oLx15DLgccWP1TCqw5+Yn01DQ16zaQ5fKvS/vZ+t9zDS+rc6AQpqCZq8be8RF+sHx2I7Yh0nb1F1lkfeTTesHr5DmO/oRKCwIY0uAx7Yh336Ybe7ARAtKxGkHw5Lwhgxj81LVvyVvka7o3ApqVqWma8ueqUsAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o39iGH2q; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bcd3c190f71so173430166b.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 21:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778475207; cv=none;
        d=google.com; s=arc-20240605;
        b=ETPONvQWarr+E6MGD0YKtO13m0f6Lw7cTuLs17i2ONJaoQIVggkfcevyiSEjpC4Hqz
         2WseKDm9CYG8fDuG/VrTAnskd/mHmhWc1tXanI4LVnVIHCGcpd1Q3iwAw0Z6Rwf0Mq4/
         GdaljIXugzzYzg95sdKtNx6RzO2G+REUdoauz4j+iP9drKkSLlhY01FZJgGYQW0ArzuU
         XG10FOWNyxHdnJJud+AwziONY1LPQ6NCtDvw3Nll5GApVa4dbtfq1P/amOeHQ2jvW0LH
         a6yfJkoKLHs3wW1afPs9yxm8bm+Ty5C5Ds+rhh5igxR3nJdQ7eAgKfr7LShJZ5zwxA5W
         qpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zloL9Ed0rrrYtG/ynMpJyid/W/AK7sYyEspxhHOS44M=;
        fh=zgGXZKw+N8d8xMC6pPSQrbJkHrEicq8wKB/AuoQWf6g=;
        b=hrfLanp8fIoIBvaYFrLPuW8Z86fdFcCW4hKhWzVFrkl703WBOukVP+Zr0H7nV2T8UV
         qR0qOozayyidkGC835cN/tr7XwatBb+fbyVgzyoI987z39LoBVNm+wqP9idWDE3bcx3w
         o/VKCRPxBNbrkGT3tkbm34jT4NhOXZINHi7XaB/BljiYFgX4YYKxmuP7dPgk37qNsx0g
         GB15HgR5Jov5wk5+eEciNiqvvepPLzRRpuCErQk4q0Tkn9ceNNWPtpEh+RGAhy61Dk4l
         Gx0DU6LLd5qvQe1I4Xuc/5FyRhJ7NnzY1WBlc5KFYVHr/hkLtZFoPc16KCstNH+RP1P0
         0rsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778475207; x=1779080007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zloL9Ed0rrrYtG/ynMpJyid/W/AK7sYyEspxhHOS44M=;
        b=o39iGH2qhU1Ru2OkHQp/t7jCn4H6b1JMFWv9iiy7b2yNSoUVnlHXFdzm6UPRRcih1w
         Ha+P8b8jHshYcJnEf3h5jEnmeYEUCQD5Gnd8KYJAzv3yAOB416jrxU5P6uHqyCiQcC1F
         jGrKFCrVkFR7e/Vjh3K9z/AZcQl2hy9jjTnbGnnEqPRc7m9XiYmIyn/VMYE5HH+T9oZ0
         3AC9KhA4EWsDriJ1a5pN2B/BPgpFfq8RS9TgQ+HLTYHxS3lEKq4tGXJWaCKv3aRhmiH7
         MFQpoazmsTkPXlMqPY0DIG6eqBy/DWdkYRHzHwhY5DBiy2E4Baca4WmbdhCzcuUUmqN+
         AQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778475207; x=1779080007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zloL9Ed0rrrYtG/ynMpJyid/W/AK7sYyEspxhHOS44M=;
        b=Dz+oWwrnKXW6+85U3MK+EwygeoKgjyl1hgcYx8cKsqtm8Oc3yHqQ9E7/if5r/IjHPY
         nJCTJJhhKYsBkufphdyjwJTyzxVPkKXWjedQ2kfDAH405Wa9rtWo/hwMc/cqU7WLXsL3
         F66sfePyOjesqgT2u2igptHPI/pCt9OwWcLDRPQ/zqueMwmhRi9EBc8i8A24FpzQarYT
         Q8ZYPezYc/uClENYoBE/bFox0K/LEvRWT6iF9Uszm5NT9psFoezDnpU0jgjWYh7ltTg2
         cffRf03F+E53a26nERTLn7RXBglFN2RT9orq8TvCmQaoQJLv0Dk9vKqMCBOU1YPSFzig
         WJJA==
X-Forwarded-Encrypted: i=1; AFNElJ9RriUmljqhNApQmTOwvroHt5T5r3oFD63dvPxmYFpg0DU0iBFDZ0HrUuDjVzKzhmwewyfe72s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmewSe8EJG8cB5ENG70wkH/0kMYgWnt4EF3BfGsOHk97f3zAz
	h3FoOkQ1v+36pr5jg4bz4dDd4mAxu5NfM4uTeqIow+ZnEJdzKsMWkt1YJkR3XC9591rybTjyiae
	Y3mV0rBDivbqL0Z3z9B3nX2QlLmktoZs=
X-Gm-Gg: Acq92OETryVoKEtJQqcnt86YBx6Xklyyot0BLYAhi6YcWfzld/OTqDSHIS6iG408ueu
	yowZIisz534WKeuRn8sP17YGwUfU/POwXYMzigpa9FyVSi2XmjS8KaK7hXcZrYZO2raBvddzHQF
	2voOHQxRf0S/MUcJ+adq6m2K/RaB6YbSKZWukzvIRlZ8Uo4s/hlbGMjLhbQmptU+wXdS4aiI3Uo
	RdS1MnFSeFs5jhtc3Z1lYu8MZDZfs7o097IqNfGsPKxjizmJWcQgZtQHuGicVzoKtMLn9opd0fz
	Mh84bSnU/JLetGtJSNFgbXcDukotthKU+mMSVi1x
X-Received: by 2002:a17:907:9284:b0:bc6:d873:fd5d with SMTP id
 a640c23a62f3a-bcc14da8b41mr360281466b.44.1778475206710; Sun, 10 May 2026
 21:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260510085426.GS15617@horms.kernel.org>
In-Reply-To: <20260510085426.GS15617@horms.kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 May 2026 01:53:14 -0300
X-Gm-Features: AVHnY4KBtkgNyYuq0pinFctaRVAR_02nU8E-3YivGjYYP5WKSZVdhVQbbJaofZI
Message-ID: <CAJq09z7AUqUixR+jo=UFAbU9mTX0X50DuZJfRcmVwEWcHTZmQQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 88F43507E9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286451-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Simon,

> There is somewhat overlapping AI-generated review of this patchset
> available at https://netdev-ai.bots.linux.dev/sashiko/ and
> https://sashiko.dev/
>
> I would appreciate it if you could look over that and address any issues
> which represent new bugs or regressions. While I think that, in general,
> any pre-existing problems that are flagged can be left as possible
> follow-up.

Thanks for the suggestion. However, it will take me some time to fix
all the issues. Most of them are real.

Regards,

Luiz

