Return-Path: <netdev+bounces-39649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1A7C044D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C4281B45
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A013B2BA;
	Tue, 10 Oct 2023 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A932FE0A
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:20:16 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820F9E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:20:14 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60980)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqIH5-00HG8b-Vu; Tue, 10 Oct 2023 13:20:12 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:44510 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqIH4-00AMOj-Fc; Tue, 10 Oct 2023 13:20:11 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: David Ahern <dsahern@gmail.com>,  Stephen Hemminger
 <stephen@networkplumber.org>,  netdev@vger.kernel.org,  Nicolas Dichtel
 <nicolas.dichtel@6wind.com>,  Christian Brauner <brauner@kernel.org>,
  David Laight <David.Laight@ACULAB.COM>
References: <20231009182753.851551-1-toke@redhat.com>
	<877cnvtu37.fsf@email.froward.int.ebiederm.org>
	<87jzrvzc5v.fsf@toke.dk>
	<87ttqznxjm.fsf@email.froward.int.ebiederm.org>
	<878r8azjgd.fsf@toke.dk>
Date: Tue, 10 Oct 2023 14:19:47 -0500
In-Reply-To: <878r8azjgd.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Tue, 10 Oct 2023 15:38:10 +0200")
Message-ID: <87y1gajne4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qqIH4-00AMOj-Fc;;;mid=<87y1gajne4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18zbDtt0MghQ0OmkuhJVCd9IaRfSlj36po=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Toke H=c3=b8iland-J=c3=b8rgensen <toke@redhat.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 881 ms - load_scoreonly_sql: 0.10 (0.0%),
	signal_user_changed: 14 (1.6%), b_tie_ro: 12 (1.4%), parse: 2.4 (0.3%),
	 extract_message_metadata: 24 (2.7%), get_uri_detail_list: 7 (0.9%),
	tests_pri_-2000: 15 (1.7%), tests_pri_-1000: 3.2 (0.4%),
	tests_pri_-950: 2.7 (0.3%), tests_pri_-900: 10 (1.2%), tests_pri_-200:
	3.1 (0.3%), tests_pri_-100: 11 (1.3%), tests_pri_-90: 131 (14.8%),
	check_bayes: 121 (13.7%), b_tokenize: 23 (2.7%), b_tok_get_all: 19
	(2.2%), b_comp_prob: 7 (0.7%), b_tok_touch_all: 63 (7.1%), b_finish:
	2.3 (0.3%), tests_pri_0: 628 (71.2%), check_dkim_signature: 1.33
	(0.2%), check_dkim_adsp: 4.1 (0.5%), poll_dns_idle: 0.98 (0.1%),
	tests_pri_10: 4.7 (0.5%), tests_pri_500: 26 (3.0%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>
>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>> There are not many places to look so something like this is probably suf=
ficient:
>>
>> # stat all of the possible/probable mount points and see if there is
>> # something mounted there.  If so recursive bind whatever is there onto
>> # the new /sys
>>
>> for dir in /old/sys/fs/* /old/sys/kernel/*; do
>> 	if [ $(stat --format '%d' "$dir") =3D $(stat --format '%d' "$dir/") ; t=
hen
>
> What is this comparison supposed to do? I couldn't find any directories
> in /sys/fs/* where this was *not* true, regardless of whether there's a
> mount there or not.

Bah.  I think I got my logic scrambled.  I can only get it to work
by comparing the filesystems device on /sys/fs to the device on
/sys/fs/cgroup etc.

The idea is that st_dev changes between filesystems.  So you can detect
a filesystem change based on st_dev.

I thought the $dir vs $dir/ would have allowed stating the underlying
directory verses the mount, but apparently my memory go that one wrong.

Which makes my command actually something like:

	sys_dev=3D$(stat --format=3D'%d' /sys)

	for dir in /old/sys/fs/* /old/sys/kernel/*; do
		if [ $(stat --format '%d' "$dir") -ne $sys_dev ] ; then
                	echo $dir is a mount point
                fi
	done


>>>> Or is their a reason that bpffs should be per network namespace?
>>>
>>> Well, I first ran into this issue because of a bug report to
>>> xdp-tools/libxdp about things not working correctly in network
>>> namespaces:
>>>
>>> https://github.com/xdp-project/xdp-tools/issues/364
>>>
>>> And libxdp does assume that there's a separate bpffs per network
>>> namespace: it persists things into the bpffs that is tied to the network
>>> devices in the current namespace. So if the bpffs is shared, an
>>> application running inside the network namespace could access XDP
>>> programs loaded in the root namespace. I don't know, but suspect, that
>>> such assumptions would be relatively common in networking BPF programs
>>> that use pinning (the pinning support in libbpf and iproute2 itself at
>>> least have the same leaking problem if the bpffs is shared).
>>
>> Are the names of the values truly network namespace specific?
>>
>> I did not see any mention of the things that are persisted in the ticket
>> you pointed me at, and unfortunately I am not familiar with xdp.
>>
>> Last I looked until all of the cpu side channels are closed it is
>> unfortunately unsafe to load ebpf programs with anything less than
>> CAP_SYS_ADMIN (aka with permission to see and administer the entire
>> system).  So from a system point of view I really don't see a
>> fundamental danger from having a global /sys/fs/bpf.
>>
>> If there are name conflicts in /sys/fs/bpf because of duplicate names in
>> different network namespaces I can see that being a problem.
>
> Yeah, you're right that someone loading a BPF program generally has
> permissions enough that they can break out of any containment if they
> want, but applications do make assumptions about the contents of the
> pinning directory that can lead to conflicts.
>
> A couple of examples:
>
> - libxdp will persist files in /sys/fs/bpf/dispatch-$ifindex-$prog_id
>
> - If someone sets the 'pinning' attribute on a map definition in a BPF
>   file, libbpf will pin those files in /sys/fs/bpf/$map_name
>
> The first one leads to obvious conflicts if shared across network
> namespaces because of ifindex collisions. The second one leads to
> potential false sharing of state across what are supposed to be
> independent networking domains (e.g., if the bpffs is shared, loading
> xdp-filter inside a namespace will share the state with another instance
> loaded in another namespace, which would no doubt be surprising).

Sigh.  So non-default network namespaces can't use /sys/fs/bpf,
because of silly userspace assumptions.  So the entries need to be
namespaced to prevent conflicts.

>> At that point the name conflicts either need to be fixed or we
>> fundamentally need to have multiple mount points for bpffs.
>> Probably under something like /run/netns-mounts/NAME/.
>>
>> With ip netns updated to mount the appropriate filesystem.
>
> I don't think it's feasible to fix the conflicts; they've been around
> for a while and are part of application API in some cases. Plus, we
> don't know of all BPF-using applications.
>
> We could have 'ip' manage separate bpffs mounts per namespace and
> bind-mount them into each netns (I think that's what you're suggesting),
> but that would basically achieve the same thing as the mountns
> persisting I am proposing in this series, but only as a special case for
> bpffs. So why not do the more flexible thing and persist the whole
> mountns (so applications inside the namespace can actually mount
> additional things and have them stick around)? The current behaviour
> seems very surprising...

I don't like persisting the entire mount namespace because it is hard
for a system administrator to see, it is difficult for something outside
of that mount namespace to access, and it is as easy to persist a
mistake as it is to persist something deliberate.

My proposal:

On "ip netns add NAME"
- create the network namespace and mount it at /run/netns/NAME
- mount the appropriate sysfs at /run/netns-mounts/NAME/sys
- mount the appropriate bpffs at /run/netns-mounts/NAME/sys/fs/bpf

On "ip netns delete NAME"
- umount --recursive /run/netns-mounts/NAME
- unlink /run/netns-mounts/NAME
- cleanup /run/netns/NAME as we do today.

On "ip netns exec NAME"
- Walk through /run/netns-mounts/NAME like we do /etc/netns/NAME/
  and perform bind mounts.

That way everything that needs to persist really and truly persists.

Applications that don't use "ip netns exec" can continue to use the
network namespace and everything that goes along with it without
problems.

>> Mount propagation is a way to configure a mount namespace (before
>> creating a new one) that will cause mounts created in the first mount
>> namespace to be created in it's children, and cause mounts created in
>> the children to be created in the parent (depending on how things are
>> configured).
>>
>> It is not my favorite feature (it makes locking of mount namespaces
>> terrible) and it is probably too clever by half, unfortunately systemd
>> started enabling mount propagation by default, so we are stuck with it.
>
> Right. AFAICT the current iproute2 code explicitly tries to avoid that
> when creating a mountns (it does a 'mount --make-rslave /'); so you're
> saying we should change that?

If it makes sense.

I believe I added the 'mount --make-rslave /' because otherwise all
mount activity was propagating back, and making a mess.  Especially when
I was unmounting /sys.

I am not a huge fan of mount propagation it has lots of surprising
little details that need to be set just right, to not cause problems.

With my proposal above I think we could in some carefully chosen
places enable mount propagation without problem.  But I would really
like to see an application that is performing mounts inside of
"ip netns exec" to see how it matters.

Code without concrete real world test use cases tends to get things
wrong.

Eric

